Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8ADB7100A21
	for <lists+linux-rdma@lfdr.de>; Mon, 18 Nov 2019 18:21:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726370AbfKRRVr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 18 Nov 2019 12:21:47 -0500
Received: from mail-qk1-f182.google.com ([209.85.222.182]:34536 "EHLO
        mail-qk1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726068AbfKRRVq (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 18 Nov 2019 12:21:46 -0500
Received: by mail-qk1-f182.google.com with SMTP id 205so15144708qkk.1
        for <linux-rdma@vger.kernel.org>; Mon, 18 Nov 2019 09:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=46kRQEGjLXi/13Wdc4yUky5fYGfAmzoz6ObUALeCZRc=;
        b=h+c6PAV1FQZNNOkGNpB0VUIry3PDvT9ukQxRXLzBQa+hUs3vQ7G4Bdg3q+4ILScOKf
         RbEtqx42O5EKNvPnToWCRIvE4QcnIEXUrgV8vozYVYIkdLQQohPzHfgFeeN2jXuvSumW
         qLKEBdpU3GiZMVXX3S0r++BY9mOEEsXlo6yUDipOYJ8RdPvVxKpNw1ad4CP3Tz7HP2Ok
         sEpfQifZFjJhaZuHCgZ/XuhoTjdrQQ0uuCVVW14uZn212dUs92RlxOKJC5+74qQuhDMr
         j2vyav5RkCLpJDY983w0AHehp65uoiU714MlUPKfjRQQ3PqZ8/3uabPPY786fvc1xFbu
         QrPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=46kRQEGjLXi/13Wdc4yUky5fYGfAmzoz6ObUALeCZRc=;
        b=GinVmMkuFcFwR4SWuAamInj0pmjxEPZSVn/oErQNcfsdUnPq9Lxvfrz0OWBMGbbP2+
         Jsaik26M+Xyv8qfJ3yNYvcV4lPXPdEvy+MfceCgi3tHefOAJ7SFPnUKJieTGyGC4IobL
         xC1L0CpmA97eVEq33KSuWHWbDbOczseZTzF4Nrn6kMXVSgLffmdPlP8rA1FtjJz4Pvr+
         sNuVD14ZJDpWptOW4eOQFtwlcQbF0wIZyd7DR2q6W81qVFZG+4J6PghcsJFzvayL2Ik4
         aLANQdZ/lFvUt5Dv/dplpt/7txTB8BoiruiYR3b0kcGpSOey+He/wUCkoVdYEHYAh+TK
         dRbw==
X-Gm-Message-State: APjAAAWV7agk7QqtzgWbQ8T1kG3lAuH/lGMwqT+QZtV73slkpX0pTsfg
        ZVbpTKFTEdIJFiz/CzOK+rn8Kg==
X-Google-Smtp-Source: APXvYqzgmLD4aoTINwFxiv31l0f8m8rcEREr9P438Y8NZVX149IH9KMWyQtx3ai3FBlv4+Szo1mJgg==
X-Received: by 2002:a37:ac09:: with SMTP id e9mr5777537qkm.63.1574097705836;
        Mon, 18 Nov 2019 09:21:45 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id 132sm8770253qki.114.2019.11.18.09.21.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 18 Nov 2019 09:21:45 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iWkie-0001Nt-Nk; Mon, 18 Nov 2019 13:21:44 -0400
Date:   Mon, 18 Nov 2019 13:21:44 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     oulijun <oulijun@huawei.com>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>
Subject: Re: =?utf-8?B?44CQaW5maW5pYmFuZF9kaWFncyB0?=
 =?utf-8?B?b29sIHF1ZXN0aW9u44CR?=
Message-ID: <20191118172144.GD2149@ziepe.ca>
References: <eca1607e-5c25-f816-9325-281b6a2d0069@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eca1607e-5c25-f816-9325-281b6a2d0069@huawei.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Sat, Nov 16, 2019 at 10:20:19AM +0800, oulijun wrote:
> Hi, Jason Gunthorpe
>     I have noticed that you have integrated infiniband_diags in the new rdma-core repo.
> I want to try to using it in RoCE. it is fail. the print as flows:
> roo
> root@(none)# ./ibaddr -g 0
>  ibwarn: [1054] mad_rpc_open_port: client_register for mgmt 1 failed
>   Failed to open (null) port 0
> 
> I found through process analysis that it needs ca to support IB_QPT_SMI.
> I understand that if hca does not support SMI, then we will not be able to use infiniband_diags tool?

I didn't think diags were really relevant for roce? The only thing
that should work is perfquery

Jason
