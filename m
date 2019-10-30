Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 63ABBEA36E
	for <lists+linux-rdma@lfdr.de>; Wed, 30 Oct 2019 19:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728253AbfJ3Seo (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 30 Oct 2019 14:34:44 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:37419 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbfJ3Sen (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 30 Oct 2019 14:34:43 -0400
Received: by mail-qt1-f193.google.com with SMTP id g50so4637421qtb.4
        for <linux-rdma@vger.kernel.org>; Wed, 30 Oct 2019 11:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OsDBDDNNwNVk1HpNMJ12vRi0lwWKIJwrDacqqrUqTjQ=;
        b=RTBhB+dV2WzXWBhflaJmPXdXqu2W7uM17qg7vysJH/Ru6ZlnTK7SAIH2Q4txGecZw3
         4uCSmn8xgzmUEREam6ZaE0gUGshvY6fb6uuj4RACu213oXWsraskau9I+VYaqhRdJBqb
         RbeuSog1yEqNie2TCj2Q4Gqn9pyVNnNMridzUN+CDvSSqUh829shisSd5XMadmJ1yKeW
         UosRRZ6GJkr6hK/tkCdch2PgHrEdf823q3DtKhUMTiFV2EDduyvyZCT4ETPRU1xlYe48
         Zyc55GYN6jU9mC6AgJqXRqipoc1jDTQXp5dJZno8tzjhE4qJkgPg7I2FshsrTBMq5+r0
         0qxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OsDBDDNNwNVk1HpNMJ12vRi0lwWKIJwrDacqqrUqTjQ=;
        b=G3lKBGpbfvi5LsuYAghetW+5JmBU1YXxHVqJkcIMUixK/Jj6q3igSBq0SbaJffKBNb
         li9nDIXXbXVNJBryhL0V8qSkaxK3ROD6x5CCB0wlxETZ6i0+OeJ6Rr8pQCEIFixKhMBx
         /BxtcbQ79FiiOe6OySm8dmnKIIYP2X6S8wf+5JYkUN3o75duyi31D6wZ2nLpTOnxKb8l
         AsJ0BQTOocV/UVbUQyv6g7qwBeH1KTSCVZk32qEfYG/y5jA9xpAQP7RUtLmCNFMuez3u
         YREXk7DlkuW3cFitEcC4s06aBz6GTuFsMBHhqOpKL0BIzLzGrRA0EqYig1IvjZ8//IJb
         D/uA==
X-Gm-Message-State: APjAAAXscbF0klLSQUtcTQ50J5OPdE3t53cuUu+37MFe3h8MDan7j8WI
        VAM4LjIDyOJzx2rO2BDvT5eUbg==
X-Google-Smtp-Source: APXvYqyjmgurV53BEYc4MsqVwfjA+33pu7DYugrs7ywxGjX6h1LZ+4/W7RrbokAPumRx5hYqHyiAvA==
X-Received: by 2002:ac8:1194:: with SMTP id d20mr1554203qtj.275.1572460482169;
        Wed, 30 Oct 2019 11:34:42 -0700 (PDT)
Received: from dhcp-41-57.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id q8sm758906qta.31.2019.10.30.11.34.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Oct 2019 11:34:41 -0700 (PDT)
Message-ID: <1572460479.5937.102.camel@lca.pw>
Subject: Re: [PATCH v3 3/3] mm/hmm/test: add self tests for HMM
From:   Qian Cai <cai@lca.pw>
To:     Jason Gunthorpe <jgg@mellanox.com>,
        Ralph Campbell <rcampbell@nvidia.com>
Cc:     Jerome Glisse <jglisse@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 30 Oct 2019 14:34:39 -0400
In-Reply-To: <20191029175837.GS22766@mellanox.com>
References: <20191023195515.13168-1-rcampbell@nvidia.com>
         <20191023195515.13168-4-rcampbell@nvidia.com>
         <20191029175837.GS22766@mellanox.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.22.6 (3.22.6-10.el7) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 2019-10-29 at 17:58 +0000, Jason Gunthorpe wrote:
> On Wed, Oct 23, 2019 at 12:55:15PM -0700, Ralph Campbell wrote:
> > Add self tests for HMM.
> > 
> > Signed-off-by: Ralph Campbell <rcampbell@nvidia.com>
> > ---
> >  MAINTAINERS                            |    3 +
> >  drivers/char/Kconfig                   |   11 +
> >  drivers/char/Makefile                  |    1 +
> >  drivers/char/hmm_dmirror.c             | 1566 ++++++++++++++++++++++++
> >  include/Kbuild                         |    1 +
> >  include/uapi/linux/hmm_dmirror.h       |   74 ++
> >  tools/testing/selftests/vm/.gitignore  |    1 +
> >  tools/testing/selftests/vm/Makefile    |    3 +
> >  tools/testing/selftests/vm/config      |    3 +
> >  tools/testing/selftests/vm/hmm-tests.c | 1311 ++++++++++++++++++++
> >  tools/testing/selftests/vm/run_vmtests |   16 +
> >  tools/testing/selftests/vm/test_hmm.sh |   97 ++
> >  12 files changed, 3087 insertions(+)
> >  create mode 100644 drivers/char/hmm_dmirror.c
> >  create mode 100644 include/uapi/linux/hmm_dmirror.h
> >  create mode 100644 tools/testing/selftests/vm/hmm-tests.c
> >  create mode 100755 tools/testing/selftests/vm/test_hmm.sh
> 
> This is really big, it would be nice to get a comment from the various
> kernel testing folks if this approach makes sense with the test
> frameworks. Do we have other drivers that are only intended to be used
> by selftests?
> 
> Frankly, I'm not super excited about the idea of a 'test driver', it
> seems more logical for testing to have some way for a test harness to
> call hmm_range_fault() under various conditions and check the results?

Not a big fan of those selftests either. Could it be saner to use the new KUnit
framework for those instead?
