Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8F3BBF1CB4
	for <lists+linux-rdma@lfdr.de>; Wed,  6 Nov 2019 18:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727824AbfKFRp4 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 6 Nov 2019 12:45:56 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:41153 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727286AbfKFRp4 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 6 Nov 2019 12:45:56 -0500
Received: by mail-qk1-f193.google.com with SMTP id m125so25343539qkd.8
        for <linux-rdma@vger.kernel.org>; Wed, 06 Nov 2019 09:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=u+U521eNteLbwhN6DhGje/HtCE9GzH8n7ys1bKcwcP4=;
        b=gY8cvytbKJaaNFIb7qR38vomGll1FZD2Os50G2Aojyvpw9sjXP06zXXx09tEjFAXGK
         LaiY5vIAZZLM4+fAEj4mhi2xlsSsU0UgEWC7ilY9NYmxqDAn84ktnLx1uWjzsnK34jmT
         PgkEnluuPkPm4PjxnAo1yakvYnv4FxNEEjHalQ6te53dlkajjsC0dHoJnjPMndahcuR6
         pGafpAGFG0dukrIVeQbsq/euWAC+SLnYe1zo1b09DlEl21ZwNY5r6v70JI0sn4vjzik9
         FO+L2gi36eB5rrrHAhI1qy+NZmCS629EIiKmcqKPFlkySUbp65WmaR0+wCbc/VYVM0fP
         wxcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=u+U521eNteLbwhN6DhGje/HtCE9GzH8n7ys1bKcwcP4=;
        b=OAcYjyU8l0SOWsK90/jG3BHelAf01+gIrTwcGlQ7NoC/JONJY7MTlLlFtuYkdjXZaC
         uKHKS0ViByALRXmikWSdEqgHE8JYoUurUp9j6eFD0ULuGBDoy67S6SKCaEpjl5K+K0sq
         b2zCUU7g+ijPpPvmyQhQXet8Jsj3USLtq5JLMJQlYFHO4xs35X+xSaJCaIFbcwt13k/r
         sZxrpPMnw/yDrpwfQL2E8BGRWnH1RSHs690okjBX0MeF1TmPvX6Dfv/sjw7vgU44EsZS
         cHqczNOxmRyhyWq/s2LAIB0DcVNTww8S8HyeCi58HKUfaKzOMvfbunEHc7xaFfdN1fBG
         l3Nw==
X-Gm-Message-State: APjAAAUaOdHOJ7vOSiX5yqGbbpUwfD2V0SltZCgND5ci5IqX3YtTQXfH
        j1WyJZz9NbJnLj8ta9AV7COs+krM8l8=
X-Google-Smtp-Source: APXvYqx4Z6dfRJw9ZjpU+IFASDsv2nWM1ls4PYWFkENhJ33Sc4V9JWKXFIofw/inrV1YiXsIGD7Zeg==
X-Received: by 2002:a05:620a:159b:: with SMTP id d27mr3152635qkk.381.1573062355867;
        Wed, 06 Nov 2019 09:45:55 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-180.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.180])
        by smtp.gmail.com with ESMTPSA id t26sm6663893qta.75.2019.11.06.09.45.55
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 06 Nov 2019 09:45:55 -0800 (PST)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1iSPNS-0005XK-Tk; Wed, 06 Nov 2019 13:45:54 -0400
Date:   Wed, 6 Nov 2019 13:45:54 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     Leon Romanovsky <leonro@mellanox.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org,
        Honggang Li <honli@redhat.com>,
        Laurence Oberman <loberman@redhat.com>
Subject: Re: [PATCH] Revert "RDMA/srpt: Postpone HCA removal until after
 configfs directory removal"
Message-ID: <20191106174554.GA21250@ziepe.ca>
References: <20191101204756.182162-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191101204756.182162-1-bvanassche@acm.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Fri, Nov 01, 2019 at 01:47:56PM -0700, Bart Van Assche wrote:
> Although the mentioned patch fixes a use-after-free bug, it introduces a
> hang during shutdown. Since the latter is worse, revert this patch.
> 
> Cc: Honggang Li <honli@redhat.com>
> Cc: Laurence Oberman <loberman@redhat.com>
> Reported-by: Honggang Li <honli@redhat.com>
> Fixes: 9b64f7d0bb0a ("RDMA/srpt: Postpone HCA removal until after configfs directory removal")
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>
> Acked-by: Honggang Li <honli@redhat.com>
> ---
>  drivers/infiniband/ulp/srpt/ib_srpt.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)

Applied to for-next, thanks

Jason
