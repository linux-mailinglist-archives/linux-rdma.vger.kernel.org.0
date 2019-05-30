Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1522301F1
	for <lists+linux-rdma@lfdr.de>; Thu, 30 May 2019 20:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbfE3S3H (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 30 May 2019 14:29:07 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42065 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726485AbfE3S3G (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 30 May 2019 14:29:06 -0400
Received: by mail-qt1-f195.google.com with SMTP id s15so8161816qtk.9
        for <linux-rdma@vger.kernel.org>; Thu, 30 May 2019 11:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Cx6BK9a8Bovpush/ENnQLMEBxmyj/Ug2etQlhUJ1CpA=;
        b=RMC6VKeqC7/g+lhrVqqPWL7vhhp43TBDMdjHMiRbsfjh6WAcpAh45gJWIyYV90KlcF
         /ccmoOv8z3TndV3Omr69q6IGrxF/HXWUj/YhBdCUrxr8rs/ytlrtj5NbAR7GYgXTbjQy
         pX7wzKbWpJ61uWUBm5j5trmbLdUq65ydZZ5f2wzSWSfW8QXQs6kyzPClPmLfhKRxuiL7
         4RBhoiOOCqKwJBldRvPTyKcYW+F56OOU3PHYVEPOXAoy7DHIov9asxvWTnd0QD4msP92
         VjBSQ+w2cRmDCQlmav4vZ5+GAMAUDDquOU5VtZYLJ96Xxz8gcqeoNw08f2uActhl7uMK
         gsXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Cx6BK9a8Bovpush/ENnQLMEBxmyj/Ug2etQlhUJ1CpA=;
        b=dKh/7d75UEPV2KOL3SRIH1XWNHp4rcOqk9nKcEyZCIEUx3ZkP0kGZM/pNaWoKwlGBX
         tzirU2o47o0zPanxlhEw6zupVA2QTulsfpLGt7tT+1eUkUS13HHwIFQr3TtCOBq6/g9v
         AiJ9UWfT9QpBIlG4Ac0RnJpEWcHkLk2TJTVgVMwlsZqqOX5KzN23FeosMT/W+ULmVLBo
         DaStZBSi53531mKiwQ2unYdZcZqYLxouxmfJqEL68hPLTCuds6DCD76csjNVe3NVWLw+
         mW3UBZ89PrDnJCscBTYhjOaC2MszkE1h8yHs/37dY5k7ewh7XBKTMY4X8XMTRFrCK6PT
         yvGw==
X-Gm-Message-State: APjAAAWPK+lsX3gLGmbSx9v/5CgZSKsuGGPOM9eingPXQrb91mgSbyo9
        CAZsTjOq8451ffFPS1RJCaBYzrVLfA0=
X-Google-Smtp-Source: APXvYqxvcjiFY8waXyV+7V5rMV1dYR/C0eN+VLTHmWnPwgHLJw4Yjw5XV6Xzk7QO7x9RDEEKQga9PQ==
X-Received: by 2002:ac8:2c33:: with SMTP id d48mr5126578qta.40.1559240945996;
        Thu, 30 May 2019 11:29:05 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id q79sm1696539qka.54.2019.05.30.11.29.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 30 May 2019 11:29:05 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hWPnV-0006b5-2M; Thu, 30 May 2019 15:29:05 -0300
Date:   Thu, 30 May 2019 15:29:05 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Dennis Dalessandro <dennis.dalessandro@intel.com>
Cc:     "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] IB/rdmavt: Use struct_size() helper
Message-ID: <20190530182905.GE13475@ziepe.ca>
References: <20190529151248.GA24080@embeddedor>
 <09563aec-f6d0-f27f-4f67-1e21cebd997c@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <09563aec-f6d0-f27f-4f67-1e21cebd997c@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, May 30, 2019 at 02:26:22PM -0400, Dennis Dalessandro wrote:
> On 5/29/2019 11:12 AM, Gustavo A. R. Silva wrote:
> > Make use of the struct_size() helper instead of an open-coded version
> > in order to avoid any potential type mistakes, in particular in the
> > context in which this code is being used.
> > 
> > So, replace the following form:
> > 
> > sizeof(struct rvt_sge) * init_attr->cap.max_send_sge + sizeof(struct rvt_swqe)
> > 
> > with:
> > 
> > struct_size(swq, sg_list, init_attr->cap.max_send_sge)
> > 
> > and so on...
> > 
> > Also, notice that variable size is unnecessary, hence it is removed.
> > 
> > This code was detected with the help of Coccinelle.
> > 
> > Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> >   drivers/infiniband/sw/rdmavt/qp.c | 4 +---
> >   1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/infiniband/sw/rdmavt/qp.c b/drivers/infiniband/sw/rdmavt/qp.c
> > index 31a2e65e4906..a60f5faea198 100644
> > +++ b/drivers/infiniband/sw/rdmavt/qp.c
> > @@ -988,9 +988,7 @@ struct ib_qp *rvt_create_qp(struct ib_pd *ibpd,
> >   	case IB_QPT_UC:
> >   	case IB_QPT_RC:
> >   	case IB_QPT_UD:
> > -		sz = sizeof(struct rvt_sge) *
> > -			init_attr->cap.max_send_sge +
> > -			sizeof(struct rvt_swqe);
> > +		sz = struct_size(swq, sg_list, init_attr->cap.max_send_sge);
> >   		swq = vzalloc_node(array_size(sz, sqsize), rdi->dparms.node);
> >   		if (!swq)
> >   			return ERR_PTR(-ENOMEM);
> > 
> 
> Looks correct, I don't think this makes the code easier to read though. The
> macro name "struct_size" is misleading to me. Maybe that's just me, and in
> any case...

It is struct_size because it computes the full size of a struct ending in a
variable length array with N items.

The previous code was wonky because it assumes that struct rvt_swqe is
the underlying type of sg_list, while the new version gets the type
information automatically.

Jason
