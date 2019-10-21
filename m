Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B6FA7DF44E
	for <lists+linux-rdma@lfdr.de>; Mon, 21 Oct 2019 19:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729859AbfJURbW (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 21 Oct 2019 13:31:22 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:39640 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729839AbfJURbV (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 21 Oct 2019 13:31:21 -0400
Received: by mail-qt1-f194.google.com with SMTP id t8so4680392qtc.6
        for <linux-rdma@vger.kernel.org>; Mon, 21 Oct 2019 10:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=c8zxuunnuRQLRlc9Sgg4rLKkDpXd52P5sbUIfhagmq8=;
        b=PEZ4ioDplMYkhiRLLVN2tth9NJjEBZYO9XaPn+3ONJA74ELVOr3iM5CASJTyQ5X0jf
         r7n38fOEjA30Rz3OK5Ybs4hcVY4rISZG2en387/3u8gvyEIvxrprcZeRed6CXYiEVnMA
         LKsbpxTqoe0g9KGJoWlE/tpFtpde4aZXquPVla9HwHD+kTPvlGrwR4B/39z294mZT5au
         OkFqMrwl8MUvN3KQFRxlmpp8SXfxcJ+R/Uy37n/11q6uSWOWelSh7/7OKY02zAfp2422
         Q6Pst4UAsMaIoxposmZWeuz41vTgFym//s5PnV3nb7xvOg0p/gt1MoTPljWbQRUPfFAH
         hDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=c8zxuunnuRQLRlc9Sgg4rLKkDpXd52P5sbUIfhagmq8=;
        b=Fo7caQQJq+WHdZxmr3RKHx03vzdh/0oCG3WjGrdLvOQubteGdbdmQ5VPtbnk36jNqf
         +WyNoS87W7v0/RWrGvzVkW1B58GyLjok5UqbrekIKjGHFg+uyNgEjKJGivc9Vqf/IER/
         5dR0GuvpWxMas1pZLXlkhgQ3MWwGgoXeKFSsmbMFuz5ZK+pP6XFHawV/p+rTFDiNvq6T
         88XFPrB6wiD+9xBy99qo6ZhOo9FifgmedkFfNIjnR7xI/HNQKXL0RWMRs3IdRZs2yj3x
         Tsu775dOWyHpuw+inCxTkwZDJXdLb6OpA9ltnqg67wYOobBf/3NvO1Kcabz/MGrTV5GH
         VKdA==
X-Gm-Message-State: APjAAAXVxzrAv76iMd7beDD5d7/qAwSevW+ZqOUlPocZIfjlrMRt+n0c
        ERyXLP9ZKaRRZbPYLs536Eh/lw==
X-Google-Smtp-Source: APXvYqxjQd/LTe6ihTlEtKESbTWjuRjIeUQam51O1pGmOCPYgVVu5dfrqMNcTHPXMG2x/pnEUjDXsg==
X-Received: by 2002:a05:6214:803:: with SMTP id df3mr4123046qvb.215.1571679080919;
        Mon, 21 Oct 2019 10:31:20 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id 14sm8031543qtb.54.2019.10.21.10.31.20
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 21 Oct 2019 10:31:20 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iMbWZ-0002B6-P5; Mon, 21 Oct 2019 14:31:19 -0300
Date:   Mon, 21 Oct 2019 14:31:19 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-next 0/4] EFA RDMA read support
Message-ID: <20191021173119.GG25178@ziepe.ca>
References: <20190910134301.4194-1-galpress@amazon.com>
 <24527b2a-3bd2-cee5-0383-277c6e72af5c@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <24527b2a-3bd2-cee5-0383-277c6e72af5c@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Oct 20, 2019 at 10:03:27AM +0300, Gal Pressman wrote:
> On 10/09/2019 16:42, Gal Pressman wrote:
> > Hi,
> > 
> > The following series introduces RDMA read support and capabilities
> > reporting to the EFA driver.
> > 
> > The first two patches aren't directly related to RDMA read, but refactor
> > some bits in the device capabilities struct.
> > 
> > The last two patches add support for remote read access in MR
> > registration and expose the RDMA read related attributes to the
> > userspace library.
> > 
> > PR was sent:
> > https://github.com/linux-rdma/rdma-core/pull/576
> 
> Should I resubmit patches 2-4?

No it is still on patchworks. You said not to apply your series until
you said it was OK

Jason
