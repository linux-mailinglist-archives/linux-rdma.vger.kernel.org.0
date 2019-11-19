Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3EA102E08
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2019 22:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfKSVK3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 16:10:29 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:37341 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726711AbfKSVK3 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Nov 2019 16:10:29 -0500
Received: by mail-qk1-f195.google.com with SMTP id e187so19258392qkf.4
        for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2019 13:10:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=j+Ps0wrlwM1Qn0FRf6Jyj/ySjaKqa/Cy9ZwyY4J3d40=;
        b=f5wI/+LVu+x9mVWI04uuUbtqtKT+q2xePllV1Ca2CnQqgjdxX4qt3T6oW0xLckGoxG
         NCB0tFXj2w+dq8slZclxq+9HWFKi42Q+t/kp+gh6N+CZ8bYCKexNztsd6wwBWrPSST0L
         aG1V4wliYQeuFG+B5L8ycxy2VtcSeGPYYopvf3Dycjsz2Ijdw7TTN/Up4IZ2/XoROOGZ
         OdvqDvS/z648GCo8Li3WAtMQfvyhey4oCTEFiOgFf7vQkRs0gH24z9KtnQhWkLpWyg7f
         y96zQ4sNwB5MLyCvI+MdrLGGMUO1oyZJ8EY9c8fXycjGgQu92BFCmEPmohuunD7JzQDe
         IYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=j+Ps0wrlwM1Qn0FRf6Jyj/ySjaKqa/Cy9ZwyY4J3d40=;
        b=KP+2DO4BxC2C5CuMUMoKN7uqdb7dH9OBfFSKvqtOcOxL0/ZlKD66ndKnIK5wvZhLc8
         r5RHVd3TEbOWB8RPiRpEqTIpr44xO0kNdRyicRagsbYLu/ZAgSyGle+KsxPQECLTrAE6
         Lv1EQqfHFGgZ/8rWEZBkTi77n3UyBbiVztplztGkHCZqGLFZy/PAxHwH7vvTsbxmFsUw
         yGtL3yDp1jW+f95YyG+K4fY4VHllAk4BXMAzU3KPCiGmW7nDP54EK2Ipc5ThQ7ItN1N3
         9JCk/2fEOiU58pMCrV7HzI3YRWaOvb7Wf/EY+lkXp7Rpjc2wtp8OELHIsnqSJRespDHY
         yJnQ==
X-Gm-Message-State: APjAAAWlHWI461wH3afMFT1Atc+IlWvmVsIARHl4d4HBq/XCxCfdOP2J
        AcVrVhcCdB3lqJCCzc3FnnCyiw==
X-Google-Smtp-Source: APXvYqyuufLrMKEZ7jS/JiyvkLZ3inKvl8noCbExomlevgtvUCKOxn8pxZi3s7XZWnRIveuRWizlcQ==
X-Received: by 2002:a37:9e86:: with SMTP id h128mr20944349qke.360.1574197828022;
        Tue, 19 Nov 2019 13:10:28 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id h12sm10645680qkh.123.2019.11.19.13.10.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Nov 2019 13:10:27 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iXAlX-0003wN-1h; Tue, 19 Nov 2019 17:10:27 -0400
Date:   Tue, 19 Nov 2019 17:10:27 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Gal Pressman <galpress@amazon.com>
Cc:     Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Daniel Kranzdorf <dkkranzd@amazon.com>,
        Yossi Leybovich <sleybo@amazon.com>
Subject: Re: [PATCH for-next 3/3] RDMA/efa: Expose RDMA read related
 attributes
Message-ID: <20191119211027.GM4991@ziepe.ca>
References: <20191112091737.40204-1-galpress@amazon.com>
 <20191112091737.40204-4-galpress@amazon.com>
 <20191119195637.GA17863@ziepe.ca>
 <60eb8f53-5284-6824-a723-f2e3fc79e921@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <60eb8f53-5284-6824-a723-f2e3fc79e921@amazon.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 19, 2019 at 10:50:06PM +0200, Gal Pressman wrote:
> On 19/11/2019 21:56, Jason Gunthorpe wrote:
> > On Tue, Nov 12, 2019 at 11:17:37AM +0200, Gal Pressman wrote:
> >> diff --git a/include/uapi/rdma/efa-abi.h b/include/uapi/rdma/efa-abi.h
> >> index 9599a2a62be8..442804572118 100644
> >> +++ b/include/uapi/rdma/efa-abi.h
> >> @@ -90,12 +90,21 @@ struct efa_ibv_create_ah_resp {
> >>  	__u8 reserved_30[2];
> >>  };
> >>  
> >> +enum {
> >> +	EFA_QUERY_DEVICE_CAPS_RDMA_READ = 1 << 0,
> >> +};
> > 
> > This doesn't seem needed, caps should only be used if a zero filled
> > reply from an old kernel is not OK.
> 
> This isn't a compatibility mask, it's our way to indicate the userspace whether
> the device supports RDMA read. Old kernel/lack of support will return 0, new
> kernel will return 0/1 according to the device support.

Ah, OK

Jason
