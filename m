Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 25A3218A9E1
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2020 01:36:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726840AbgCSAgr (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 18 Mar 2020 20:36:47 -0400
Received: from mail-qv1-f65.google.com ([209.85.219.65]:38425 "EHLO
        mail-qv1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726596AbgCSAgr (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 18 Mar 2020 20:36:47 -0400
Received: by mail-qv1-f65.google.com with SMTP id p60so131082qva.5
        for <linux-rdma@vger.kernel.org>; Wed, 18 Mar 2020 17:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=fqdpgXYcUZijy2Tim4u70zVZLXSOAEfPxfR1JdoPz+o=;
        b=eF92YLiEaamcZiN6MXf0NWxBawKcgVk/aO7nYp/v0aF+nAyU8fZ8yRayp7R2SYysw4
         gUDqIZs8WLlKEdONsjZUMAOkY2AKTPsFj9zNxWfNqDyrgVCZOJ/ydBgY+TNr8wDObmpQ
         vuQEW3RbUbb7MMLkOGyXavxHs+M233FNPmLzszDaTXyq4DrXj5Pz9J437XjVLsyUbG4w
         tmc/sYlEXyrtobrU4DSfE4A3nqv2RVETnhfp5ZbYTYWeROIpkeXaI7ywUpT6lXSynk9a
         klU0QrudtOz21VAM7ZAg5omyvS4zRBfMs221owN2xgHT8hC0vfQN+34mbKS51HV1Mf66
         6mtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=fqdpgXYcUZijy2Tim4u70zVZLXSOAEfPxfR1JdoPz+o=;
        b=hi/kHMlw/hxA7ZYe0Oa4XpTMwZNAmBccdFtwo6h2cLp5V5XCY4gybpp6aBGap6JN0R
         2SMiCDdo7/QE3ci46jCGXMI9ybRFIcDOWlX99bcrmp/yAYSEFpOpKN5M+ZHLzgAJIUxc
         dfopG/jsa/n+o5TGoFySif/5sC7e2A2CqDeZtKTorpsJT9w9GjxOk3dmcXMcXxW2eZHl
         lMcP+OlZq/ZkqbLshZ7742EOvQ7SuZAMgrhpkSm/LVUfraEFyOJTPANgMno8DPJEXFQQ
         RI4cmh//RGTI/nl//2WK4mLt2AMrllGWnrOuVrISjYnYb5/kl3o1I8ZUCLiwJ/liO8BV
         Aelw==
X-Gm-Message-State: ANhLgQ3OnepRUGPx6KKNPejWxKJk6QswfDLRPb7OBZ0SdgGoyIuI5ARy
        kPm5TwLMlG2e2W4oMu6BqqxBUQ==
X-Google-Smtp-Source: ADFU+vsFt1BuB+oCHIvm0540W/zf+ZnzvOL6/mgS9/sImW9FgDFqvnX787lcAKwo39SFTXr3uTX5dg==
X-Received: by 2002:a05:6214:72f:: with SMTP id c15mr605415qvz.3.1584578206504;
        Wed, 18 Mar 2020 17:36:46 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-142-68-57-212.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.68.57.212])
        by smtp.gmail.com with ESMTPSA id t7sm310920qtr.88.2020.03.18.17.36.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 18 Mar 2020 17:36:45 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1jEjAz-0002ID-Cs; Wed, 18 Mar 2020 21:36:45 -0300
Date:   Wed, 18 Mar 2020 21:36:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc:     Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        Dennis Dalessandro <dennis.dalessandro@intel.com>,
        Niranjana Vishwanathapura <niranjana.vishwanathapura@intel.com>,
        Doug Ledford <dledford@redhat.com>, linux-rdma@vger.kernel.org
Subject: Re: [PATCH 14/17] infiniband: pa_vnic_encap.h: get rid of a warning
Message-ID: <20200319003645.GH20941@ziepe.ca>
References: <cover.1584456635.git.mchehab+huawei@kernel.org>
 <9dce702510505556d75a13d9641e09218a4b4a65.1584456635.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dce702510505556d75a13d9641e09218a4b4a65.1584456635.git.mchehab+huawei@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, Mar 17, 2020 at 03:54:23PM +0100, Mauro Carvalho Chehab wrote:
> The right markup for a variable is @foo, and not @foo[].
> 
> Using a wrong markup caused this warning:
> 
> 	./drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h:243: WARNING: Inline strong start-string without end-string.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  drivers/infiniband/ulp/opa_vnic/opa_vnic_encap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Do you want this to go to the RDMA tree? I wasn't cc'd on the cover
letter

Otherwise

Acked-by: Jason Gunthorpe <jgg@mellanox.com>
 
Thanks,
Jason
