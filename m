Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B455C131D17
	for <lists+linux-rdma@lfdr.de>; Tue,  7 Jan 2020 02:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727295AbgAGBRk (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 6 Jan 2020 20:17:40 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:43659 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbgAGBRk (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 6 Jan 2020 20:17:40 -0500
Received: by mail-qt1-f193.google.com with SMTP id d18so41356463qtj.10
        for <linux-rdma@vger.kernel.org>; Mon, 06 Jan 2020 17:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=bMjACsiL6KncNf0rovmI7z57gWx3xoTjZZNaMYoEg9w=;
        b=IWJcZO/DOEyB6YYAI4GyDqKPc8Gtxhfsu8BNHDu9J9mAcqAJ6JEOKXM56vlU8afECz
         wPzv+9rSUlO3Rd1I6sBVZsrMtzKDvYSRN4nnerzHR73qUXOScJo3Bci5TERzWkLQsuqo
         yhj/eRoUY942ZQTQZkFCSZgp5XO/GtWk+RJij3cQzl/fEe0j9Egx24OMEApWFhxE57sd
         zIQyXin/6qsLbkZsGGkXrNKtiX/qIcfnoIM0we44t/jUEPsXaXZRP3imWIZmbRRRbpR5
         IJvSnoDeMbjn0Rpa8Jp409/PeYAgMhYZ2qt5KYHzbICZeYPQdKJ2qlg0F8qitDzKciox
         W39Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bMjACsiL6KncNf0rovmI7z57gWx3xoTjZZNaMYoEg9w=;
        b=tIIheNqz4hcWl39xwXBVZ/Ek//WiF56tmIQ0Qx+ZNYDaUS0GSNf7BJBNhIVqRxH+Wk
         YbcLHFSUVkuhiHxqqEBAo+QjqQeE+SQFJlQk2aBr0ZAsl7i/Y1rQua4zwTnM9CQxIkvy
         iq9MIFKaT+a4HmmWe/HtvduRe2Q/PKuJLwbPGYFSkqRfCtfeZm5Mips5vDWzTU/rWhZR
         9S5rCCDE1/0eT3fjd1Bgdg7YL7b3u4gkMZ6m1B4GtG5ykdKt6vC21wnDnZS9BZ9oL2/n
         HSVe6WwyEoWJkoZW+8RJJCBJOYUK0LdB2tufQijosoIoOMdXh7g3JIrs6rRg39zvWd+r
         e0ig==
X-Gm-Message-State: APjAAAVPhEBMAgkdBfsi3gbpBEelHbbYTkdBsYXefy+hHjxfN9MsHuDq
        3uuyXdaWhlxUaUyTecqciNWdDg==
X-Google-Smtp-Source: APXvYqx7cDEGS1MlF7exQfyGyqvwHqBi6GpVD2ES7T1yc5fqssey6AlQeEwK3pukf/+h/+VewFtUMg==
X-Received: by 2002:ac8:5257:: with SMTP id y23mr77109147qtn.88.1578359859396;
        Mon, 06 Jan 2020 17:17:39 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id g9sm21474176qkm.9.2020.01.06.17.17.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Jan 2020 17:17:38 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iodV4-0005Mi-B9; Mon, 06 Jan 2020 21:17:38 -0400
Date:   Mon, 6 Jan 2020 21:17:38 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Doug Ledford <dledford@redhat.com>,
        Leon Romanovsky <leonro@mellanox.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Sean Hefty <sean.hefty@intel.com>
Subject: Re: [PATCH rdma-rc v2 05/48] RDMA/cm: Request For Communication
 (REQ) message definitions
Message-ID: <20200107011738.GA19858@ziepe.ca>
References: <20191212093830.316934-1-leon@kernel.org>
 <20191212093830.316934-6-leon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191212093830.316934-6-leon@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Dec 12, 2019 at 11:37:47AM +0200, Leon Romanovsky wrote:

> +/* Table 106 REQ Message Contents */
> +#define CM_REQ_LOCAL_COMM_ID CM_FIELD32_LOC(struct cm_req_msg, 0, 32)
> +#define CM_REQ_SERVICE_ID CM_FIELD64_LOC(struct cm_req_msg, 8, 64)
> +#define CM_REQ_LOCAL_CA_GUID CM_FIELD64_LOC(struct cm_req_msg, 16, 64)
> +#define CM_REQ_LOCAL_Q_KEY CM_FIELD32_LOC(struct cm_req_msg, 28, 32)
> +#define CM_REQ_LOCAL_QPN CM_FIELD32_LOC(struct cm_req_msg, 32, 24)
> +#define CM_REQ_RESPONDED_RESOURCES CM_FIELD8_LOC(struct cm_req_msg, 35, 8)

RESPONDER not RESPONDED

> +#define CM_REQ_PRIMARY_LOCAL_PORT_LID CM_FIELD16_LOC(struct cm_req_msg, 52, 16)
> +#define CM_REQ_PRIMARY_REMOTE_PORT_LID CM_FIELD16_LOC(struct cm_req_msg, 54, 16)
> +#define CM_REQ_PRIMARY_LOCAL_PORT_GID CM_FIELD_MLOC(struct cm_req_msg, 56, 128)
> +#define CM_REQ_PRIMARY_REMOTE_PORT_GID CM_FIELD_MLOC(struct cm_req_msg, 72, 128)
> +#define CM_REQ_PRIMARY_FLOW_LABEL CM_FIELD32_LOC(struct cm_req_msg, 88, 20)
> +#define CM_REQ_PRIMARY_PACKET_RATE CM_FIELD_BLOC(struct cm_req_msg, 91, 2, 2)

This field is 6 bits wide, not two. This is the only mistake in the
field layouts.

Jason
