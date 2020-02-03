Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A81CF1510FA
	for <lists+linux-rdma@lfdr.de>; Mon,  3 Feb 2020 21:26:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726224AbgBCU0s (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 3 Feb 2020 15:26:48 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:35321 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726187AbgBCU0s (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 3 Feb 2020 15:26:48 -0500
Received: by mail-qt1-f195.google.com with SMTP id n17so11384283qtv.2
        for <linux-rdma@vger.kernel.org>; Mon, 03 Feb 2020 12:26:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mVebTVoG0uWjjgGpSieazY2tiuchgTUEKvCRKCWsDd8=;
        b=hK5x0A1XO/Klun2AlPoq/6xa1ZG1WJZZfj18aMXWEmxzXnOZ4JQrIugxlR8rj93Srs
         AONw3Bh2O0oR2PhWTyT+yzQQuuqNVrY8cHJB6gkiXbQS/VLDfDVzSjAc5tLPN3OLfsHJ
         hlxKN4+7L3uVsqdJJAZ1bWqkT37ahkzgliIaVVhuUBlYoOvQpJ/DOVeoI9sIzgUvwFK8
         W5PRep5yLjXhQdpdGQQq3JszXDf0eNOvas3LI2vZzcF/vmg0gf5RqUlH7tReRywK88Yq
         Qy7Rf97OMRs1C1O2CdnB5dVhuMVn2xEQVhoyebV5pOvyG4KFWqK/zqf9U3wUevlD66+f
         di+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=mVebTVoG0uWjjgGpSieazY2tiuchgTUEKvCRKCWsDd8=;
        b=OHKFnJlhQ9S+Ye6OdSn8Y157069X1MnsBL7TDTtobeOWJNT5qaaXSOLYoYwOuj/rYU
         jyMHDOtmev/aUMa/R0lSLPn8+U/5X12fyNiqTZZzSWToJV7rqXcV+L9SP6uY/VFT4tNS
         UpyD+uXZz+GeHVSEzp3dlJBfEoEtlc25roLYgQbd9Y6vAsoqdCmup4KYpgu+9VjMP4vw
         lu1mVyP/+8zDbNoVBJnfR6u/EstGaV0e6MywXRN40U30gQ2oZ94ZRpFhANn92fCnsUg/
         Iat35NcYv+LdegSF4omYZKY/ZaSyIdDeb+68AVG02CgTwTEhlXRCBcM2I8JK13/dgPUG
         IYxw==
X-Gm-Message-State: APjAAAWPud+wTv8R/qdXU4shkULl8NhAca7sEL4YzYGVkY/+5wAmi5VE
        ojhO6SE3JDD9fUbfJ2l554+p/g==
X-Google-Smtp-Source: APXvYqwQRkl1po9AfnjBbBhmfRAJdlH/qAZiVI/XThwIko+Kx7usYtXvcTUofRmPfD1W8zIeqPfNfQ==
X-Received: by 2002:ac8:104:: with SMTP id e4mr25014646qtg.37.1580761607504;
        Mon, 03 Feb 2020 12:26:47 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id w21sm11028411qth.17.2020.02.03.12.26.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Feb 2020 12:26:46 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iyiIw-0005DI-Du; Mon, 03 Feb 2020 16:26:46 -0400
Date:   Mon, 3 Feb 2020 16:26:46 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     YuvalShaiayuval.shaia.ml@gmail.com
Cc:     aditr@vmware.com, pv-drivers@vmware.com, dledford@redhat.com,
        linux-rdma@vger.kernel.org, Yuval Shaia <yuval.shaia.ml@gmail.com>
Subject: Re: [PATCH] RDMA/vmw_pvrdma: Disable PCI device on error
Message-ID: <20200203202646.GC14732@ziepe.ca>
References: <20200203183736.10932-1-yuval.shaia.ml@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203183736.10932-1-yuval.shaia.ml@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Feb 03, 2020 at 08:37:36PM +0200, YuvalShaiayuval.shaia.ml@gmail.com wrote:
> From: Yuval Shaia <yuval.shaia.ml@gmail.com>
> 
> We need to disable the PCI device on any error happen after we enable
> the device.
> 
> Signed-off-by: Yuval Shaia <yuval.shaia.ml@gmail.com>
>  drivers/infiniband/hw/vmw_pvrdma/pvrdma_main.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Lets have fixes lines for this and the other patch please

Jason
