Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9927B67183
	for <lists+linux-rdma@lfdr.de>; Fri, 12 Jul 2019 16:35:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727108AbfGLOfs (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 12 Jul 2019 10:35:48 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:36647 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727072AbfGLOfs (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 12 Jul 2019 10:35:48 -0400
Received: by mail-qt1-f195.google.com with SMTP id z4so8295535qtc.3
        for <linux-rdma@vger.kernel.org>; Fri, 12 Jul 2019 07:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=XuyXDtAvolBfZ+rbhmoC0vapYY2fhXsMaEPS8JgdSzk=;
        b=Khf83+1erPS4Bjk1Inb9QANWh2rghFCU9j+dUFqCDVP2ogWB80iifQGquMjNx20qRV
         OKG0dCe07T8gHi5MVAudRToPT+9bdbgfoxCHkR9YXKi9sj6AakCF+OSUqRj/rLWAPLMv
         CckRDI6fX81mdULOiMz9i2Ux2CiezKcwFhz6ktOPA0s1GPAHvWRoIPDrZ2M0Qq2NtI0W
         pZU5jK9D7wiCaeo9xFaaGU5Bnh7WUEVv3U2JBjMvLNcPRLVNDNb6i3wrOCRTI1sfPwrh
         xlOSDPDoxpkRyxIUpDFU5wj+7aJc+kgiOVyMtTI+EYsP9zNSgJxe0QlZuie0o+b5qX3p
         gcmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=XuyXDtAvolBfZ+rbhmoC0vapYY2fhXsMaEPS8JgdSzk=;
        b=f+axpQ7hM6uT5AcK/Zuz4REoaDY/YEIocmHx8P2knrZtFlT0ieAb22hf9+YdExZ0CR
         eYSXxZOTnLfFuMvkowidzaCAuetCmt37CUPCIbxR0ZmXTSyo+2ff8bwJx6tkUqzU9EOn
         njVU6RTnmRqpCIGm1sXJ2ATEESqg6uWuJgFxyBSq2X8BX+QZbroJRAsJl4Vsjh/mFObY
         22YDzjYaKhD5feZuHtCsriwefNR1MjMJrpnWDzVjR8smrZBiX0pE4mN4QfMQmReqUR8A
         YwAODYCplTUBVckFqtpOyAnVGN9TX5moWgrrUodLVLiz3tYe6DTnHRKdZENd6p/L/z0t
         2Mzw==
X-Gm-Message-State: APjAAAUAV250kaTJzObmHJTem4sgKK4T/MIWmnfuCcE9cBs48b4LzQOK
        SmNc+sMLfNDJ9+xf+XpEnAN8sUoztuhyzg==
X-Google-Smtp-Source: APXvYqzlvld4ipwPMMCTDr7nJPPuKWvHx+SabHZi/o5em9CyYWesfnKG/zJTRw/t+Z5/xz/1cTYPZQ==
X-Received: by 2002:a0c:ea34:: with SMTP id t20mr6882497qvp.11.1562942147689;
        Fri, 12 Jul 2019 07:35:47 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id n18sm3514439qtr.28.2019.07.12.07.35.47
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 12 Jul 2019 07:35:47 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hlweI-0001oo-N9; Fri, 12 Jul 2019 11:35:46 -0300
Date:   Fri, 12 Jul 2019 11:35:46 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Potnuri Bharat Teja <bharat@chelsio.com>
Cc:     linux-rdma@vger.kernel.org, BMT@zurich.ibm.com, monis@mellanox.com,
        nirranjan@chelsio.com
Subject: Re: User SIW fails matching device
Message-ID: <20190712143546.GD27512@ziepe.ca>
References: <20190712142718.GA26697@chelsio.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190712142718.GA26697@chelsio.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Jul 12, 2019 at 07:57:19PM +0530, Potnuri Bharat Teja wrote:
> Hi all,
> I observe the following behavior on one of my machines configured for siw.
> 
> Issue:
> SIW device gets wrong device ops (HW/real rdma driver device ops) instead of
> siw device ops due to improper device matching.
> 
> Root-cause:
> In libibverbs, during user cma initialisation, for each entry from the driver 
> list, sysfs device is checked for matching name or device.
> If the siw/rxe driver is at the head of the list, then sysfs device matches 
> properly with the corresponding siw driver and gets the corresponding siw/rxe 
> device ops. Now, If the siw/rxe driver is after the real HW driver cxgb4/mlx5 
> respectively in the driver list, then siw sysfs device matches pci device and 
> wrongly gets the device ops of HW driver (cxgb4/mlx5).
> 
> Below debug prints from verbs_register_driver() and driver_list entries, where 
> siw is after cxgb4. I see verbs alloc context landing in cxgb4_alloc_context 
> instead of siw_alloc_context, thus breaking user siw.
> 
> <debug> verbs_register_driver_22: 184: driver 0x176e370
> <debug> verbs_register_driver_22: 185: name ipathverbs
> <debug> verbs_register_driver_22: 184: driver 0x176f6a0
> <debug> verbs_register_driver_22: 185: name cxgb4
> <debug> verbs_register_driver_22: 184: driver 0x176fd50
> <debug> verbs_register_driver_22: 185: name cxgb3
> <debug> verbs_register_driver_22: 184: driver 0x1777020
> <debug> verbs_register_driver_22: 185: name rxe
> <debug> verbs_register_driver_22: 184: driver 0x1770a30
> <debug> verbs_register_driver_22: 185: name siw
> <debug> verbs_register_driver_22: 184: driver 0x1771120
> <debug> verbs_register_driver_22: 185: name mlx4
> <debug> verbs_register_driver_22: 184: driver 0x1771990
> <debug> verbs_register_driver_22: 185: name mlx5
> <debug> verbs_register_driver_22: 184: driver 0x1771ff0
> <debug> verbs_register_driver_22: 185: name efa
> 
> <debug> try_drivers: 372: driver 0x176e370, sysfs_dev 0x1776b20, name: ipathverbs
> <debug> try_drivers: 372: driver 0x176f6a0, sysfs_dev 0x1776b20, name: cxgb4
> <debug> try_drivers: 372: driver 0x176fd50, sysfs_dev 0x1776b20, name: cxgb3
> <debug> try_drivers: 372: driver 0x1777020, sysfs_dev 0x1776b20, name: rxe
> <debug> try_drivers: 372: driver 0x1770a30, sysfs_dev 0x1776b20, name: siw
> <debug> try_drivers: 372: driver 0x1771120, sysfs_dev 0x1776b20, name: mlx4
> <debug> try_drivers: 372: driver 0x1771990, sysfs_dev 0x1776b20, name: mlx5
> <debug> try_drivers: 372: driver 0x1771ff0, sysfs_dev 0x1776b20, name: efa
> 
> Proposed fix:
> I have the below fix that works. It adds siw/rxe driver to the HEAD of the 
> driver list and the rest to the tail. I am not sure if this fix is the ideal 
> one, so I am attaching it to this mail.

Update your rdma-core to latest and this will be fixed fully by using
netlink to match the siw device..

Jason
