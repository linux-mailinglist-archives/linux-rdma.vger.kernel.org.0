Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7D493BDB5
	for <lists+linux-rdma@lfdr.de>; Mon, 10 Jun 2019 22:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389573AbfFJUp0 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 10 Jun 2019 16:45:26 -0400
Received: from mail.kernel.org ([198.145.29.99]:55348 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389331AbfFJUp0 (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Mon, 10 Jun 2019 16:45:26 -0400
Received: from gmail.com (unknown [104.132.1.77])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id AEBBC206E0;
        Mon, 10 Jun 2019 20:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560199526;
        bh=Sl6eccgIpGpXLNppse+kSAkAyOn3m0wVLWUt3obSHyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=zTYSn31RcPA2WX6cjULsR/Ho2AraR/emd9uyH0WKJSCC3pPJPEjKnW/TePvawiJLE
         bLkMs32JvmlgZiogJd0HU6hbOkJrDAoCR333d/pCsLMdzCiRSUQ1Q7KPNx5qdgTwUS
         P/1zaXfSy7L902vw2AQhy2pSYKjiB+AEG/SmISFo=
Date:   Mon, 10 Jun 2019 13:45:24 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     syzbot <syzbot+e5579222b6a3edd96522@syzkaller.appspotmail.com>,
        dasaratharaman.chandramouli@intel.com, dledford@redhat.com,
        leon@kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, parav@mellanox.com,
        roland@purestorage.com, sean.hefty@intel.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: WARNING: bad unlock balance in ucma_event_handler
Message-ID: <20190610204523.GK63833@gmail.com>
References: <000000000000af6530056e863794@google.com>
 <20180613170543.GB30019@ziepe.ca>
 <20190610184853.GG63833@gmail.com>
 <20190610194732.GH18468@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190610194732.GH18468@ziepe.ca>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Jun 10, 2019 at 04:47:32PM -0300, Jason Gunthorpe wrote:
> 
> There are many unfixed syzkaller bugs in rdma_cm, so I'm not surprised
> it is still happening..
> 
> Nobody has stepped forward to work on this code, and it is not a
> simple mess to understand, let alone try to fix.
> 

But people still use it, right?  Do they not care that it's spewing syzbot
reports?  Are they depending on the kernel to provide any security properties?

- Eric
