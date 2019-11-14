Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6B9AFCA4D
	for <lists+linux-rdma@lfdr.de>; Thu, 14 Nov 2019 16:54:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfKNPyP (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 14 Nov 2019 10:54:15 -0500
Received: from mail-qk1-f196.google.com ([209.85.222.196]:36881 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726444AbfKNPyP (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 14 Nov 2019 10:54:15 -0500
Received: by mail-qk1-f196.google.com with SMTP id e187so5397024qkf.4
        for <linux-rdma@vger.kernel.org>; Thu, 14 Nov 2019 07:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=myBRwdIDZM+Djx89Bjwq7BC5pRJnKbB6UM2UOeE1ngM=;
        b=hIJ4WdJ5jLRRBKUeeeQYewM0jfBPnGo2ACjOPRADok7azxxt/mq+Xu0ZcrHBEURYx5
         ahJpC1hjBbHDu4genHAKTCpFr4ZdFDdWB30DzFHfUtjBxk8Pak1MA1+2zYI+ZIHo59si
         uYQd2/mjzJUvpYm46EsyViPmpkRYxll9vWL0o3qz0YZDUto0u42GLl3Dw9C+TvtWK9gP
         HoidKjHn5rbZzxrd4Pha7PAhjBgSgqP/eP0UzbNS30JBp9uCcfAN6tnxQAbF6LlcaNKh
         2xnq6RLNunTsrQDvF3FRvsDRN6ho8dqVUz8UntG4rqZsJn4a6wU5nMIYgm7lN+xYDtbW
         uCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=myBRwdIDZM+Djx89Bjwq7BC5pRJnKbB6UM2UOeE1ngM=;
        b=ElKKgIKJsl4FVWmDiWlw/5Iitr1pzQnwHBPAAMiDBH30zSS0DyL5U2ADiocfExImC4
         kYhF3ZKqLCe2IK6PMXf1V3HMpRwIh+/1CQtf63Wihnp8KWPzW6AwyI+bVrH0KiM528to
         ngFTEdAt6BZ7RX5jhkUUDUETIpxP40L1Lj4YJYk6qNgmhwprkXs0ONJT8pmCtz/93hTw
         vrbS1T1VfzTShDkiUuLJqqr9FZwgiNO2mqaKpMA0o+PaJLtDOMlAxpQGTgtuLa3awv6O
         gxSITAiPtLFpXQzro4UV4gDV/ZYWOUHQ6VkzS4I2Oj1YH1YhjCH8sJuCwXPL9TGhD++r
         VEnQ==
X-Gm-Message-State: APjAAAUxGUF2clCVNbUIajS0+oCskPTrRvscAwWAF0jc1Pe10xD0if0E
        9XK1mvjZGeM2peRXek9yL9SinA==
X-Google-Smtp-Source: APXvYqwBG7oO5AQ60VNus1jTs0EnXEv8zPuEped9XQRtFUTUc+wX8i+pnFxeVhu9jneS34v/MggT9A==
X-Received: by 2002:a37:a104:: with SMTP id k4mr8108780qke.412.1573746854820;
        Thu, 14 Nov 2019 07:54:14 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id t26sm3468891qta.75.2019.11.14.07.54.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Nov 2019 07:54:14 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iVHRl-0007bZ-SW; Thu, 14 Nov 2019 11:54:13 -0400
Date:   Thu, 14 Nov 2019 11:54:13 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Viresh Kumar <viresh.kumar@linaro.org>
Cc:     Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Mike Marciniszyn <mike.marciniszyn@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IB/qib: Validate ->show()/store() callbacks before
 calling them
Message-ID: <20191114155413.GA29207@ziepe.ca>
References: <d45cc26361a174ae12dbb86c994ef334d257924b.1573096807.git.viresh.kumar@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d45cc26361a174ae12dbb86c994ef334d257924b.1573096807.git.viresh.kumar@linaro.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Thu, Nov 07, 2019 at 08:50:25AM +0530, Viresh Kumar wrote:
> The permissions of the read-only or write-only sysfs files can be
> changed (as root) and the user can then try to read a write-only file or
> write to a read-only file which will lead to kernel crash here.
> 
> Protect against that by always validating the show/store callbacks.
> 
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
>  drivers/infiniband/hw/qib/qib_sysfs.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Applied to for-next, thanks

Jason
