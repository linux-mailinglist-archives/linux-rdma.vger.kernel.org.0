Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C1BA4118EDF
	for <lists+linux-rdma@lfdr.de>; Tue, 10 Dec 2019 18:22:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727599AbfLJRWg (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 10 Dec 2019 12:22:36 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:39020 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727553AbfLJRWg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 10 Dec 2019 12:22:36 -0500
Received: by mail-oi1-f194.google.com with SMTP id a67so10526699oib.6
        for <linux-rdma@vger.kernel.org>; Tue, 10 Dec 2019 09:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+yXS1qMqBQgYNWoie6aez+kq4hBmW6bci2Vzcn52mDU=;
        b=n3myC2TiVG4k/XZaOe+3WrOokgsqMo+ejKQ1Gof/FryawAQcojQ9xlSLSfOVPrTGyT
         JeEoP3M/NOzo/nt9DOs0Es/bi82NDOH+rjNZW7tOjwF+Ecdgnf0ylNC3L2fecxsvaMLS
         jVzASl3DLL86yIURm1S+OruWqXJ7Scu/dx0cZG1YshxkGzEy4c5YbAoT0UH7RbPuaR+r
         nRY4b8HIW9ABLAbw8VXl0ebEeZ6ZEXZSDM8t4gVJdKin4vuKg1gW09Q/rDMEgurrZFfr
         UYsCHv+BQsmHKdZCubIglZ6Dx3fqjBGwsRK8VtDPVAzEFW44c2wYbbCKr0zKRXEvVJqt
         fQlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+yXS1qMqBQgYNWoie6aez+kq4hBmW6bci2Vzcn52mDU=;
        b=pVSJjAmyAAaLR53+OYZvafyt3tfY2IXbawfl5m9jk8U+XKxLTcvBNjYyYPmhPY+Rzt
         yly9c5Z45/ghUC2odLjKWKrHLF3+X5Kc94hE41Dq9TsbVnZxvLn2ylB70Ouyiv93JjlO
         FH1XfNrG73GR+9SIMOD/3QUiyOjUZXPSzSQFuEyYXvWRbHZ9GBncXPOK61yzutkZCtf4
         vjlxNG8Fx0U0HHLKAKfUJFIxB9WESLH6fyXtaC6S0flXkMkxB4M0A47+Me3k9hPVMFBJ
         Vycutd1dt8u2YpPvRKBdOky2ggSgW2vbRDBwEyeemyfmFUfVkGTQZZNdcn1+9S70dWHA
         eXkA==
X-Gm-Message-State: APjAAAWFuJwpv3IX30neBHrnwW3louQ92nywbRpTl0mzePL6eKca+6Bl
        yUBWv/YjO0ji8zdjoYmq/INBcg==
X-Google-Smtp-Source: APXvYqzhYtCBUztj+R5JygBJ57q/e4L0cYCUZRTereZX4deELFDYjhTZ0Jf5pObGnLqqXLToJ06w1g==
X-Received: by 2002:aca:50cd:: with SMTP id e196mr4954490oib.178.1575998555399;
        Tue, 10 Dec 2019 09:22:35 -0800 (PST)
Received: from ziepe.ca ([217.140.111.136])
        by smtp.gmail.com with ESMTPSA id g203sm1588884oib.17.2019.12.10.09.22.34
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Dec 2019 09:22:34 -0800 (PST)
Received: from jgg by LT-JGG-7470.mtl.com with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iejDW-000013-0n; Tue, 10 Dec 2019 13:22:34 -0400
Date:   Tue, 10 Dec 2019 13:22:33 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Cc:     davem@davemloft.net, gregkh@linuxfoundation.org,
        netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
        nhorman@redhat.com, sassmann@redhat.com, parav@mellanox.com
Subject: Re: [net-next v3 00/20][pull request] Intel Wired LAN Driver Updates
 2019-12-09
Message-ID: <20191210172233.GA46@ziepe.ca>
References: <20191209224935.1780117-1-jeffrey.t.kirsher@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191209224935.1780117-1-jeffrey.t.kirsher@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, Dec 09, 2019 at 02:49:15PM -0800, Jeff Kirsher wrote:
> This series contains the initial implementation of the Virtual Bus,
> virtbus_device, virtbus_driver, updates to 'ice' and 'i40e' to use the new
> Virtual Bus and the new RDMA driver 'irdma' for use with 'ice' and 'i40e'.
> 
> The primary purpose of the Virtual bus is to provide a matching service
> and to pass the data pointer contained in the virtbus_device to the
> virtbus_driver during its probe call.  This will allow two separate
> kernel objects to match up and start communication.
> 
> The last 16 patches of the series adds a unified Intel Ethernet Protocol
> driver for RDMA that supports a new network device E810 (iWARP and
> RoCEv2 capable) and the existing X722 iWARP device.  The driver
> architecture provides the extensibility for future generations of Intel
> hardware supporting RDMA.
> 
> The 'irdma' driver replaces the legacy X722 driver i40iw and extends the
> ABI already defined for i40iw.  It is backward compatible with legacy
> X722 rdma-core provider (libi40iw).

Please don't send new RDMA drivers in pull requests to net. This
driver is completely unreviewed at this point.

Jason
