Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DEBB7D0096
	for <lists+linux-rdma@lfdr.de>; Tue,  8 Oct 2019 20:15:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729686AbfJHSPq (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 8 Oct 2019 14:15:46 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:43756 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726138AbfJHSPq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 8 Oct 2019 14:15:46 -0400
Received: by mail-qk1-f193.google.com with SMTP id h126so17663376qke.10
        for <linux-rdma@vger.kernel.org>; Tue, 08 Oct 2019 11:15:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mieG1gGWd0XXwzRpCzufez0lKtTveyi+n5LrNWa3MnE=;
        b=eT1mUlDUpB6nXTIv3Ux2P5jByTa3VBzq3nUDg7ZFtse2Uh3pnAOBKObZ8sRU+UwGxS
         dw1ZkQY3qBegxdL73ux2XnS6N/vkMf8Yb4OSotkkOTD6cJ3i3CN2nN0w9EcM3Dytmc6f
         GvuE7mZlO9Vc1snDqohREHsIJbflSofCrZ/TOKdWY9HTDaaJROVCkVg6t+zzpC1sTfO7
         Dvtdxs7U0AzS9nfDxc22lKMx9acZDot5ZIIA63Oe/wyPOjmKPQ2+bUntgMfpifVUY6c7
         e1OHxi85M630Nw42WadM9wiKUEQBeVNKvxDEs3ug4N4aaW2k3UhQJBiS5YfwkuZ/3Pgl
         dcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mieG1gGWd0XXwzRpCzufez0lKtTveyi+n5LrNWa3MnE=;
        b=Ad6j0146gDIj1KcgzU/C1m0CHjVzt7hFylSkxqhGVeYg8Byi08aRDqqQlsOcc4r7sq
         whTRBzYM4OLBDE47S0SkbamUXa41GxUU5BQRhyus4GBwYFzyq4zCk2lfiB31bd2qMNMO
         Gum6VCEdVn/iWy2Y0xNZBjXo3kNtky8ajRK/oO182nv44iOATzOn1LCz3ReBAxPV0UV7
         VQrRTIz6B1EhsILPJmAiQTZJb1SpUZ611MwPfFJRrO3jWNnkIo9DQIvQ9ck3aeqdNqeY
         xmpF5LPUJjRbNLK9XgqOoqxmGeWiOuKMthC4fzosYY+mpxUxITJo/YDDFHmScVAdyzLD
         a7dw==
X-Gm-Message-State: APjAAAV5FsE9EQarV61jtB1S1qkeTdiIQhyqO10mQJaxC8JvhyOsdKVK
        qBGMP23k+opf2lbRnnidxjmAv/ph16c=
X-Google-Smtp-Source: APXvYqyzTApjjir6SjjUnKpZdjA0uq6lXzS9iY965pBDGIVpICiU/rd/xK4oH5bRvi2Ty6zrYvKtEw==
X-Received: by 2002:a37:aa02:: with SMTP id t2mr30297328qke.154.1570558545173;
        Tue, 08 Oct 2019 11:15:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id p22sm8335918qkk.92.2019.10.08.11.15.44
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 08 Oct 2019 11:15:44 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iHu1Q-0000yc-47; Tue, 08 Oct 2019 15:15:44 -0300
Date:   Tue, 8 Oct 2019 15:15:44 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Adit Ranadive <aditr@vmware.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bryan Tan <bryantan@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>
Subject: Re: [PATCH for-next v1] RDMA/vmw_pvrdma: Use resource ids from
 physical device if available
Message-ID: <20191008181544.GA2880@ziepe.ca>
References: <1568924678-16356-1-git-send-email-aditr@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1568924678-16356-1-git-send-email-aditr@vmware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Sep 19, 2019 at 08:24:56PM +0000, Adit Ranadive wrote:

>  
> +	if (!qp->is_kernel) {
> +		if (ucmd.flags == PVRDMA_USER_QP_CREATE_USE_RESP) {

Why does this flag exist? Don't old userspaces pass in a 0 length?
Just use the length to signal new userspace?

> +			qp_resp.qpn = qp->ibqp.qp_num;
> +			qp_resp.qp_handle = qp->qp_handle;
> +			qp_resp.qpn_valid = PVRDMA_USER_QP_CREATE_USE_RESP;
> +
> +			if (ib_copy_to_udata(udata, &qp_resp,
> +					     sizeof(qp_resp))) {

This should limit the copy size to the length of the user buffer

Jason
