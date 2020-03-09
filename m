Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6E39D17E8BF
	for <lists+linux-rdma@lfdr.de>; Mon,  9 Mar 2020 20:37:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726271AbgCITh1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 9 Mar 2020 15:37:27 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:38295 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbgCITh1 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 9 Mar 2020 15:37:27 -0400
Received: by mail-qt1-f195.google.com with SMTP id e20so7949322qto.5
        for <linux-rdma@vger.kernel.org>; Mon, 09 Mar 2020 12:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=hYTyJkaX0oR+VoRwP3356Zdx1QLJ7O4bI0P5gRpieic=;
        b=JLxRn1Obiq4BOACjQmUCl8xL11VfvXtz+FpFKciJ9xUAQsh0ctFgJNGFtKUVtNUPwX
         MeAP5upxU2cPnJYiF2L4EgSlD4jwEUNVC7lvV/Zq4OrxiLG4G8QQQe7w3VkRyntbcJqo
         ckh1Ov82hOvWHLN6e4sssayWh8O6J7pQzOo/KZbi4mdoEYYjW6F+4EPg+/91hYLD2PZF
         hIpZvXAxH7qF/fViCldijBD9KIhV3o9UBtGIfYwBUHyJH+gtDxqS5xrVo+U6QspLySUM
         jsCOEDNejCVG+OOzpDDkIITijRKMk6ZODCsoCe+32jf+jnuegZrFc5AQjVmrfb2Sh/8C
         a73w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hYTyJkaX0oR+VoRwP3356Zdx1QLJ7O4bI0P5gRpieic=;
        b=DhK4bwcNCGPyyaMBUPndifYwqOdZbhHa1oDWQ8Z3FgBUZyehNQRaDmxakMf+haL76l
         7l/77v76UtLCxDC8v9gURonjNyWfB9A4vKun6nu2oCXGshJ2BcuG2p9KdohZ0ozIjFi2
         PUDcDWEyFuyvwkHdGBQWb6zs9VXZLC7Gn8OKo9MH2dyOx3F5/Ai60DX18loFkYACZXaF
         vK3FSyV3PljIuYC0/ZdB+F5xlTlVW5rorg3gulD/Td3CGXD26zbyZ3NsDXKFRnj44xCQ
         oTvSqT0UCyfX3mRp82G3DdDTbS0PE+CGdw9bLIi/RYh47zVgf/7SUyBSte5lfvrXm+k+
         VbJA==
X-Gm-Message-State: ANhLgQ2ZHTx9456iSkd997830RZ544R70u4qSR1TDRdDM+NQksbmIMMi
        9mpYo1hN2KMYD6dXcRT7oms6jLuvTzY=
X-Google-Smtp-Source: ADFU+vspxxSR/eTRRE7Yt5cOoPxCutiFQBRXM0HX1U8o3tDrUn8ODelhGZjgB0KrniCZZ0iWW6hB/w==
X-Received: by 2002:ac8:47cf:: with SMTP id d15mr16066242qtr.17.1583782645996;
        Mon, 09 Mar 2020 12:37:25 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id v80sm22563673qka.15.2020.03.09.12.37.25
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 09 Mar 2020 12:37:25 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jBODM-0002vn-So; Mon, 09 Mar 2020 16:37:24 -0300
Date:   Mon, 9 Mar 2020 16:37:24 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Changming Liu <liu.changm@northeastern.edu>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Subject: Re: [bug report]infiniband: integer overflow in ib_uverbs_post_send
Message-ID: <20200309193724.GX31668@ziepe.ca>
References: <BL0PR06MB4548B04CFD3A77B4DCCA74DFE5E10@BL0PR06MB4548.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BL0PR06MB4548B04CFD3A77B4DCCA74DFE5E10@BL0PR06MB4548.namprd06.prod.outlook.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sun, Mar 08, 2020 at 03:48:36AM +0000, Changming Liu wrote:
> This email is sent because the previous one was rejected due to it was in html form.
> 
> From: Changming Liu 
> Sent: Friday, March 6, 2020 8:50 PM
> To: dledford@redhat.com; jgg@mellanox.com
> Cc: linux-rdma@vger.kernel.org; yaohway@gmail.com
> Subject: [bug report]infiniband: integer overflow in ib_uverbs_post_send
> 
> Hi Doug and Jason:
> Greetings, I'm a first year PhD student who is interested in the usage of UBSan in the linux kernel, and with some experiments I found that in
> /drivers/infiniband/core/uverbs_cmd.c function ib_uverbs_post_send, there is a unsigned integer overflow which might cause undesired behavior.
> 
> More specifically, the cmd structure, after the execution uverbs_request_start, are filled with data from user space. Then two __u32 integers in this structure are multiplied together as shown as followed,
> 
> wqes = uverbs_request_next_ptr(&iter, cmd.wqe_size * cmd.wr_count);

It doesn't matter, this is computing a __user pointer which is always
used with copy_to_user. If the user overflows this multiply then they
will get EFAULT instead of ENOSPC.

In all cases copy_to_user will not allow the kernel to be harmed.

Jason
