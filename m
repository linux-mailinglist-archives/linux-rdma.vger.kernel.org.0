Return-Path: <linux-rdma+bounces-1457-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9457C87D315
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Mar 2024 18:51:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CE8C1F21529
	for <lists+linux-rdma@lfdr.de>; Fri, 15 Mar 2024 17:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 711FD4CB41;
	Fri, 15 Mar 2024 17:51:52 +0000 (UTC)
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958804AED8;
	Fri, 15 Mar 2024 17:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710525112; cv=none; b=tsLawyvuPZmUZjHay5+DteIwypXr0WwthEfzfKpXdev4WskdGiIku4xThjDHlEo2JeeWHJk27G1UZ21FLxpsXmNR69QxvNmOJoCwQ8ZcKOVyNOB5cDcn0Cah7pjI+NQdjtuobrFggppOslLTULPE34RYliRlKTpIchwacz0zB7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710525112; c=relaxed/simple;
	bh=3Xw33QmgVj0mYkZZEX6Jxx0BTb+yNOI1PCk8MJ0g6tk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F7fuJwS3LeqFrpdrByO1MfFQcsc1pDLUmye5Q1Td2pN+L60AN0mnWXVeqv5rggLXoifY4VymKR1ue/DmptPtCw37HVw9j7zPrvf7wz/Z8kI7jRQolheY0DrdafGwHETLoc8OpaVx66PaxiUJADs7PrVuJfdhTe2kzIAQFfpby+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51381021af1so3415693e87.0;
        Fri, 15 Mar 2024 10:51:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710525109; x=1711129909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tKhttWeTZFZe9zGUUxoh+QILRHPUFPMvrl4pX6JuEh4=;
        b=TlZjcU/t5Ff0pWtH0BTmcn0R4VgIZ6yRoa3rHlbR/cyar8kx0AqFyfewidQnFxl/MV
         T8LvvJGyEoXMcY+ky7NjgNFZWFUj+0lLXyTbJQrRr+C+5H5/eTU68asw2SJW8hpm7kGe
         7Tt7zaGIHC8ETKLnQ60FW83664dX7ExkPAosSPGrI1bY2rCaBlafN8IIpE+ImyW+NBud
         nVlu+EIGRvQ73brUp61MNE1qBxgPAIi8bCz18uOGRIyLZNK5KCTIM0/QatDfwY2alV0e
         EJCDMcCJ0T71rrk2pqKGRrwL/hxmgekIeXzNbCh/LOzlErO2XYXTfks9zCEpTsXroAYT
         rj/w==
X-Forwarded-Encrypted: i=1; AJvYcCXjdXeIv/zkH3FnXDZyqh2zd/dN7xcC9DlU1js8YTi98C0rjU3A2HMb5cMx2QwqYtVLjoR8Y7Yff1MoYb1vEvt65e7OYW+PQtbzPoSXhVXC2c9J0QufXtiuHbzM5o6jTGPSxM+QRH1slA==
X-Gm-Message-State: AOJu0YzB6gxZPeiko+FAmw9vHbihCJOhiyhs1mJkVRTJD5jGASnKYcJE
	DOJXJgMpPM9vZAPhp6BYyUiey+hUZyqkpT5mD23OwZYyLeJX3Ur1V8wyrb6D
X-Google-Smtp-Source: AGHT+IF/c3BPTZYiyPuy/ur+dDx7XiyuV58K0kECKS3LK4Gs0Mj/UPQI5yuWMVnm9aQCmeFZi0cVAA==
X-Received: by 2002:a19:8c57:0:b0:513:226c:651d with SMTP id i23-20020a198c57000000b00513226c651dmr3196443lfj.2.1710525108467;
        Fri, 15 Mar 2024 10:51:48 -0700 (PDT)
Received: from gmail.com (fwdproxy-lla-002.fbsv.net. [2a03:2880:30ff:2::face:b00c])
        by smtp.gmail.com with ESMTPSA id n8-20020a170906118800b00a45be04f00fsm1922934eja.171.2024.03.15.10.51.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Mar 2024 10:51:48 -0700 (PDT)
Date: Fri, 15 Mar 2024 10:51:46 -0700
From: Breno Leitao <leitao@debian.org>
To: Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
	kuba@kernel.org, keescook@chromium.org,
	"open list:HFI1 DRIVER" <linux-rdma@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] IB/hfi1: allocate dummy net_device dynamically
Message-ID: <ZfSKskdFpbGVgnk4@gmail.com>
References: <20240313103311.2926567-1-leitao@debian.org>
 <b4cf355e-8310-422c-8ff8-9e96d7efc9e5@cornelisnetworks.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b4cf355e-8310-422c-8ff8-9e96d7efc9e5@cornelisnetworks.com>

On Fri, Mar 15, 2024 at 12:12:15PM -0400, Dennis Dalessandro wrote:
> On 3/13/24 6:33 AM, Breno Leitao wrote:
> > struct net_device shouldn't be embedded into any structure, instead,
> > the owner should use the priv space to embed their state into net_device.
> > 
> > Embedding net_device into structures prohibits the usage of flexible
> > arrays in the net_device structure. For more details, see the discussion
> > at [1].
> > 
> > Un-embed the net_device from struct hfi1_netdev_rx by converting it
> > into a pointer. Then use the leverage alloc_netdev() to allocate the
> > net_device object at hfi1_alloc_rx().
> > 
> > [1] https://lore.kernel.org/all/20240229225910.79e224cf@kernel.org/
> > 
> > Signed-off-by: Breno Leitao <leitao@debian.org>
> > 
> > ----
> > PS: this diff needs d160c66cda0ac8614 ("net: Do not return value from
> > init_dummy_netdev()") in order to apply and build cleanly.
> > ---
> > Changelog:
> > 
> > v2:
> > 	* Free struct hfi1_netdev_rx allocation if alloc_netdev() fails
> > 	* Pass zero as the private size for alloc_netdev().
> > 	* Remove wrong reference for iwl in the comments
> > ---
> 
> Very lightly tested, but interface came up and I could send traffic. Code seems
> OK too.
> 
> I'd prefer to at least remove the first sentence of the commit message.

That is OK for me. Would you like to remove it when merging it, or,
would you prefer me to resend it?

Thanks

