Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 062DB13F94B
	for <lists+linux-rdma@lfdr.de>; Thu, 16 Jan 2020 20:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730919AbgAPTYJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 16 Jan 2020 14:24:09 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38997 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733088AbgAPTYI (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 16 Jan 2020 14:24:08 -0500
Received: by mail-qk1-f193.google.com with SMTP id c16so20296671qko.6
        for <linux-rdma@vger.kernel.org>; Thu, 16 Jan 2020 11:24:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=e4/z0umMohmgQB5HhskF+31qfU2NQcCR4vvmoWLJ4cE=;
        b=owqavWUhKk1J6MPPCu7wzQDUMF+dd3/sRpNGOlaP3t0R+B94mcSwanMfizJDmd0AQJ
         VzN0YNnbEoXkfn0ZewHSMch6LcHT+4uKXTRhzB5/tZfzcGfMDDUpX3c5/Pl8bStBHw+h
         sVtAehKrEjOQLkckWet6hm+kVLKr2cwVcLQS742PSQ1TTOLWMhMcryzIcMFUiMi7wUKS
         lF71vniGJ+Kd1X4x7WL+nlwa5ypIB35+jfzdxaKNFpRSfWuYDwXKgwD4tCeaBwpZn/Gc
         UpV2k3GciUECCB6Osant4e2VefMsdm+kDlmFMGDm7dyYopROEDQcr5yFXMb42T/5w8al
         wyzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=e4/z0umMohmgQB5HhskF+31qfU2NQcCR4vvmoWLJ4cE=;
        b=iWbxzeSwQoLMRve/f2/yUljGJXZH5JJ1rEkiMe4BWpscwXSiKtYkjTlW3MxevllxH3
         VHMgsbSQO1og6MlwIsL4dAe/LnK7CfgJ9eG4MtoIxuQQtxcCyIvZCAzLRBqBsQmhgeIi
         Di3bVxvS2ozLdX1pr3rOl/CcZPpbA2Y8m2IeLlhREAI/ci5v6kKicx174vnXP2UhyhSw
         Xzjgogn3Ok9kA366Dq6PmUckNIGuD6oAmuvuSCNUCXENh52KRcX840aHQ1BLuQxUhxb2
         s456x9iCSkAMoWSFT9eiyLlFt9cOLsepCbLkWWkpcQ8lDWjSiT8VX/t2ZCrNUYHSpb5H
         ZoUA==
X-Gm-Message-State: APjAAAXQLPA4tRDeZxhdkGm3bgrEZXqUeF/10Zr0ZnMf3xqZNv/VVgIb
        sywE//N1pBZdYmRw1ghQKTJTSQ==
X-Google-Smtp-Source: APXvYqybolHbGE3JTvmrEpeyIpUzCKU5N69jKxbjGpaXZG2hwfQRW3UenCJavr20+2XUd7MTXNZ3aQ==
X-Received: by 2002:a37:801:: with SMTP id 1mr35686766qki.326.1579202647486;
        Thu, 16 Jan 2020 11:24:07 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id i5sm11613265qtv.80.2020.01.16.11.24.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 16 Jan 2020 11:24:06 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1isAkO-0002jF-HP; Thu, 16 Jan 2020 15:24:04 -0400
Date:   Thu, 16 Jan 2020 15:24:04 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-rc v2 00/48] Organize code according to IBTA layout
Message-ID: <20200116192404.GE10759@ziepe.ca>
References: <20191212093830.316934-1-leon@kernel.org>
 <20200107184019.GA20166@ziepe.ca>
 <20200116073208.GG76932@unreal>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200116073208.GG76932@unreal>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Jan 16, 2020 at 09:32:08AM +0200, Leon Romanovsky wrote:

> 2. IMHO, you don't need to include your selftest in final patches, because
> the whole series is going to be accepted and that code will be added and
> deleted at the same time. Especially printk part.

I like seeing the tests. For a patch like this, which is so tedious to
review, it makes the review a check of the tests, a check of the
spatch and some spot checks of the transformations.

Since it is a small number of lines, and it is much easier than
sending the tests separately, it felt reasonable to leave them in the
history.

Will you be able to send the _be removal conversions you had done on
top of this?

I didn't show it, but all the private_data_len, etc should be some
generic IBA_NUM_BYTES() accessor like get/set instead of more #defines.

Jason
