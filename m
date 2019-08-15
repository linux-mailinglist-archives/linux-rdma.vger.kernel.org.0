Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD2DB8EC61
	for <lists+linux-rdma@lfdr.de>; Thu, 15 Aug 2019 15:07:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732042AbfHONHm (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 15 Aug 2019 09:07:42 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:42227 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730304AbfHONHm (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 15 Aug 2019 09:07:42 -0400
Received: by mail-qt1-f195.google.com with SMTP id t12so2205227qtp.9
        for <linux-rdma@vger.kernel.org>; Thu, 15 Aug 2019 06:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=502PNjJ03tb74tMbD+BofBD7Dbg2E/vBEOvDVeixxNg=;
        b=BqUUXWs7AS5ik2TPWkYX7s538Te5FqlfaUo8uRvkshw/l6aDkS2lVA7w5ReLCw0nMp
         Jxo0RKxSPardxbFZbZGpfUVAhlIrDgdxbN1pyIuMfIA7rli8t0tRlMu9AGnHfM0f1Dqa
         tZixr0DLUGsOU5oau1EKiLQTy88QlaYE1bjmE1ekUKVd5wXcSMgok+G3GBBI22U5u18l
         p0hbBi+pIwH2n8iVXEFUXwpHvD3AZpSSf7k+p+CMd2cw8rAhFoXTq4QK9GcS+36+NdFV
         4MIzuYqau6jhaYQ3/MEX+qWFYFa4jncSjkEyojDlOt6Iy63Bqm+tGHsGw/emKU1u0fjE
         J3MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=502PNjJ03tb74tMbD+BofBD7Dbg2E/vBEOvDVeixxNg=;
        b=OWWFI0WOPM2ZEl3V89aQhrqs5M7zmemf9MJ14guPBMWUx2l70xT0vF3dS/xL+1Z6F/
         ygg3t9GzpXM6sNrRNWTsc7Iapdk+424Y7slyTpfGFBudL37koiI0ADevSAjR45mlhW8f
         f7OHk7CaG94BD1C1p/rppefgZMuFoFY1Xs7xaLQV1ReAQ7Twaiqmrki0E2g7D2iP4Bq/
         xUEy770NHu1jjKAM8jHkBn+QtCnmH/BGbqwYCttsAIglug97Gs7tIMJUdd0O9GStPKq/
         muogmPwcdICswJohGT1vn/iTgOYri7o/A4WueTTI76xcPXL9PyBYRDrPZcnfXBx6tJKV
         Sxyw==
X-Gm-Message-State: APjAAAVE0GTtxfJPvKSCrW0K31IoYJPab/9fXyF3RMKs3JdGh7ZtUSgK
        dUwEXI6sEsq+AIhSKiM1bRL7Pg==
X-Google-Smtp-Source: APXvYqzEoX4q/8t96Kg9WS2o6QHOo926gKFpEe8wD3a5oRFyfEd805f+Gk3CLfoWje/Vg28g4p4AHw==
X-Received: by 2002:ac8:1c42:: with SMTP id j2mr3833404qtk.68.1565874461077;
        Thu, 15 Aug 2019 06:07:41 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id g3sm1366704qke.105.2019.08.15.06.07.40
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 15 Aug 2019 06:07:40 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hyFTg-0004JC-9d; Thu, 15 Aug 2019 10:07:40 -0300
Date:   Thu, 15 Aug 2019 10:07:40 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Selvin Xavier <selvin.xavier@broadcom.com>
Cc:     dledford@redhat.com, linux-rdma@vger.kernel.org
Subject: Re: [PATCH for-rc] RDMA/bnxt_re: Fix stack-out-of-bounds in
 bnxt_qplib_rcfw_send_message
Message-ID: <20190815130740.GE21596@ziepe.ca>
References: <1565869477-19306-1-git-send-email-selvin.xavier@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1565869477-19306-1-git-send-email-selvin.xavier@broadcom.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Aug 15, 2019 at 04:44:37AM -0700, Selvin Xavier wrote:
> @@ -583,7 +584,7 @@ int bnxt_qplib_create_srq(struct bnxt_qplib_res *res,
>  	req.eventq_id = cpu_to_le16(srq->eventq_hw_ring_id);
>  
>  	rc = bnxt_qplib_rcfw_send_message(rcfw, (void *)&req,
> -					  (void *)&resp, NULL, 0);
> +					  (void *)&resp, sizeof(req), NULL, 0);

I really don't like seeing casts to void * in code. Why can't you
properly embed the header in the structs??

Jason
