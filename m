Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9CD63E771A
	for <lists+linux-rdma@lfdr.de>; Mon, 28 Oct 2019 17:58:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403934AbfJ1Q6Q (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 28 Oct 2019 12:58:16 -0400
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39611 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726234AbfJ1Q6Q (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 28 Oct 2019 12:58:16 -0400
Received: by mail-qk1-f194.google.com with SMTP id 15so9126247qkh.6
        for <linux-rdma@vger.kernel.org>; Mon, 28 Oct 2019 09:58:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=m/BeVnyofYf34YPdTEokBsn94UGmDCe2QBWixeooqog=;
        b=C3Cew3fmy8Lu3iiOLuewdFZdThmCGPaVyn7RdtCw0XkeDcNO0jihWd2z5v9qR4CBYm
         yPnVEUq3LMfFb4GpCbi48C4sqD79jEc2llzhuFkqKfkUnOJkOuDg6ZgfULT0FIfkE1yF
         E7FRE7Lh0Ut8H+94gEjzElNRED/1Fl7sbidW4eue4x6Lana3TiCGzh8WBd1TA5FWmTST
         t4txMq7J87srk2MJzkQNR273X7nX1O36UMMeZLTe/s9cKX2gb6FG0Nf45R9guh3q2HZ5
         tEqnnmn6ao8AucqdB7GryhaRiFayUGt924axL63jeJT6335f/4GrW1CG5kuJCbKnb0PO
         5Spw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=m/BeVnyofYf34YPdTEokBsn94UGmDCe2QBWixeooqog=;
        b=grZErMxxADcAKX+1MRinE7LWSMzrjtqVh6IyuOp1Bh2xcNcU6VJbz4a+B6OimWjW5g
         9T7sc787EY3Lqzn4vJSMeNPu1IK4vVILrtpuFHTsDun/1gIuV0BNAKFWAEP28UqOSO1X
         jKqNqwREmrKjtLBSGNW6lY5JKqL2tvbk8/qNYppZuqBOCIC/IHLl5UQbBRTGBYFr/WXK
         BEerHUogcMbOYvBZIb7AZvgW6KCdIS7sgPpuWC7KLnGab5xVn4VgR4VZDMGpmbXLzWgv
         hRb8SOJ0YCVpUWk8BaEgjfTxvKGJA4KIn4O89V+py0yq0HVLBYtSrs5FWvDenuUz3BjK
         +xDw==
X-Gm-Message-State: APjAAAX2B6pnJxfYQwUBkT4mpVmKlqgv/zirhxu5qL8TgLVIfFYigOs5
        3ktJUX9UYZzGDUG38+Hz41mARw==
X-Google-Smtp-Source: APXvYqxK14mKEJ72+/ypymIlYsCqxJhPNrTc50JQH+1U6sCyohjHmGbqG86JBEkvB4QrCJRXqP/rig==
X-Received: by 2002:a05:620a:12a8:: with SMTP id x8mr17426396qki.396.1572281894955;
        Mon, 28 Oct 2019 09:58:14 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id y28sm5982905qky.25.2019.10.28.09.58.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 28 Oct 2019 09:58:14 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iP8LN-0006XJ-T6; Mon, 28 Oct 2019 13:58:13 -0300
Date:   Mon, 28 Oct 2019 13:58:13 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Adit Ranadive <aditr@vmware.com>
Cc:     "dledford@redhat.com" <dledford@redhat.com>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        Bryan Tan <bryantan@vmware.com>,
        Pv-drivers <Pv-drivers@vmware.com>
Subject: Re: [PATCH v2] RDMA/vmw_pvrdma: Use resource ids from physical
 device if available
Message-ID: <20191028165813.GG29652@ziepe.ca>
References: <20191022200642.22762-1-aditr@vmware.com>
 <20191028162756.GA16475@ziepe.ca>
 <8f14c8c9-db10-2bb6-51b8-6e3b8b0167be@vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f14c8c9-db10-2bb6-51b8-6e3b8b0167be@vmware.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Oct 28, 2019 at 04:46:09PM +0000, Adit Ranadive wrote:
> On 10/28/19 9:27 AM, Jason Gunthorpe wrote:
> > On Tue, Oct 22, 2019 at 08:06:50PM +0000, Adit Ranadive wrote:
> >> @@ -195,7 +198,9 @@ struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
> >>  	union pvrdma_cmd_resp rsp;
> >>  	struct pvrdma_cmd_create_qp *cmd = &req.create_qp;
> >>  	struct pvrdma_cmd_create_qp_resp *resp = &rsp.create_qp_resp;
> >> +	struct pvrdma_cmd_create_qp_resp_v2 *resp_v2 = &rsp.create_qp_resp_v2;
> >>  	struct pvrdma_create_qp ucmd;
> >> +	struct pvrdma_create_qp_resp qp_resp = {};
> >>  	unsigned long flags;
> >>  	int ret;
> >>  	bool is_srq = !!init_attr->srq;
> >> @@ -260,6 +265,15 @@ struct ib_qp *pvrdma_create_qp(struct ib_pd *pd,
> >>  				goto err_qp;
> >>  			}
> >>  
> >> +			/* Userspace supports qpn and qp handles? */
> >> +			if (dev->dsr_version >= PVRDMA_QPHANDLE_VERSION &&
> >> +			    udata->outlen != sizeof(qp_resp)) {
> > 
> > Is != really what you want? Or is <= better? != means you can't ever
> > make qp_resp bigger.
> 
> I thought about using != or < before sending the patch. Since we removed
> the flag anyways using != here made sense to be more strict about what's
> acceptable. I'm not sure if we'll ever make it bigger.

It is a big gamble you will never need to add new entries to this
struct forever more. Better to be safe, IMHO.

Jason
