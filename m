Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F18D1102BCC
	for <lists+linux-rdma@lfdr.de>; Tue, 19 Nov 2019 19:39:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727117AbfKSSjf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 19 Nov 2019 13:39:35 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:40474 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726307AbfKSSjf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 19 Nov 2019 13:39:35 -0500
Received: by mail-qt1-f194.google.com with SMTP id o49so25770879qta.7
        for <linux-rdma@vger.kernel.org>; Tue, 19 Nov 2019 10:39:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=SOEJxEj9oIEIVsG/zRT02HK+wpkShyxOtFJF6OpvlpU=;
        b=lgciHTrL4zjeT9ofoyulo27FzBjN3O5lzlJ9PSPYN2olSQzHtqJBrG+mK9twgUQA/E
         aI1ERwBvoqKOjC187dIBEIEPOtaOHciwclLE0fnxvxq3TB687w+2CMydZJHuIa/4rMFl
         J6PRXjWl0AMhGj9kC5t9QLH6tclCRszbLvJKpiGNoMvPJcV34FrGpOwZeYXV40/+8Tcf
         eDIKpN6FMcyQ68FcE/OAaq5nwqBz9bOp/k3J6K4seSUC0MAvAQi0epQH58TvRhB0J1k8
         kHy6WKPr5ulvryHuY00s1AsvTBdrT40+W+1qt2Kjm9lclGk3KMNUihtOJDjqUPhVFPCA
         +rkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=SOEJxEj9oIEIVsG/zRT02HK+wpkShyxOtFJF6OpvlpU=;
        b=CZSXGtp7+uqqIS8PNqjIGE0aHmmBXo7d55AnCzlc/syRUq5wPy145GlY7h/JNH1OBp
         TJhIvqNzwGOs16eCuuKD7ldT1FQ5WnEICTUygkllMTuddbWo28fs2vwGOOzypEPoI+26
         Xw0857g9nTW2CKGReCs51JtA5wSd4lLx+rr7kl4UyJmcalBYu0mGJJiour5INEAos9iz
         8sxcZ22iN5I1sjYvZXImcgjVI96dl+9Xx6GjVp5hboRbBXp0ltIyxGfIXdpzg+JHJxW9
         dwyg0H7V1szDFJ1crRsxqHKubW27bEhxkL7N2Wx75EyjvDpBmp5LfFPMRzXesuQZ6GyX
         PJEg==
X-Gm-Message-State: APjAAAUvVBKaOKiGuugY7RL3J0ajqKAWUQhMKA2VZjjXu/GaQlHdPzMO
        d7hUv9DdZU4X1ov5lTqjP2cBKg==
X-Google-Smtp-Source: APXvYqyiah9HNfH4YgRvOC4FTqbDhMgpczO0pASYLW3AIe+nXFBvm6NutIPSxKt6zl71rgOpWZvhpQ==
X-Received: by 2002:aed:35f4:: with SMTP id d49mr34095933qte.20.1574188774135;
        Tue, 19 Nov 2019 10:39:34 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id c20sm13309025qtc.13.2019.11.19.10.39.33
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 19 Nov 2019 10:39:33 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iX8PU-0002LJ-U5; Tue, 19 Nov 2019 14:39:32 -0400
Date:   Tue, 19 Nov 2019 14:39:32 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     "Ertman, David M" <david.m.ertman@intel.com>
Cc:     Parav Pandit <parav@mellanox.com>,
        "Kirsher, Jeffrey T" <jeffrey.t.kirsher@intel.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "nhorman@redhat.com" <nhorman@redhat.com>,
        "sassmann@redhat.com" <sassmann@redhat.com>,
        "Patil, Kiran" <kiran.patil@intel.com>
Subject: Re: [net-next v2 1/1] virtual-bus: Implementation of Virtual Bus
Message-ID: <20191119183932.GG4991@ziepe.ca>
References: <20191115223355.1277139-1-jeffrey.t.kirsher@intel.com>
 <AM0PR05MB4866CF61828A458319899664D1700@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <2B0E3F215D1AB84DA946C8BEE234CCC97B301493@ORSMSX101.amr.corp.intel.com>
 <AM0PR05MB4866169E38D7F157F0B4DC49D14C0@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <AM0PR05MB486682813F89233048FCB3D1D14C0@AM0PR05MB4866.eurprd05.prod.outlook.com>
 <2B0E3F215D1AB84DA946C8BEE234CCC97B30165F@ORSMSX101.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2B0E3F215D1AB84DA946C8BEE234CCC97B30165F@ORSMSX101.amr.corp.intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Nov 19, 2019 at 05:46:50PM +0000, Ertman, David M wrote:

> > With this, I forgot to mention that, virtbus doesn't need PM callbacks,
> > because PM core layer works on suspend/resume devices in reverse order
> > of their creation.
> > Given that protocol devices (like rdma and netdev) devices shouldn't be
> > anchored on virtbus, it doesn't need PM callbacks.
> > Please remove them.
> > 
> > suspend() will be called first on rdma device (because it was created last).
> 
> This is only true in the rdma/PLCI LAN situation.  virtbus can be used on two
> kernel objects that have no connection to another bus or device, but only use
> the virtbus for connecting up.  In that case, those entities will need the PM
> callbacks.

PM order is something to be careful of, the callbacks for a virtbus
driver have to happen before the PCI segment that driver is actually
on gets shutdown.

Is it possible to get PM callbacks directly from the PCI device
without binding a driver to it? I think not..

So, either a driver-specific path has to relay PM callbacks from the
owning PCI device to the attaching sub driver

Or, we have to rely on the driver core to manage PM for us and
instantiate a virtbus segment under the PCI device such that normal PM
callback ordering works properly. (this would be my preference)

Ie we shut down the virtbus under 01:00.0 then we shut down 01:00 ,
then PCI bus 01:00, then the root complex, etc.

Look to I2C for an example how this looks in sysfs

Jason
