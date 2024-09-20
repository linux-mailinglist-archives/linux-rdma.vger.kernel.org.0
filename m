Return-Path: <linux-rdma+bounces-5024-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2220797D5DE
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2024 14:56:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9461C21165
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Sep 2024 12:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A862816A94F;
	Fri, 20 Sep 2024 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jIHx/5Yr"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E382A168C3F
	for <linux-rdma@vger.kernel.org>; Fri, 20 Sep 2024 12:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726837000; cv=none; b=aUKjz+lZZpTJnezJisJsmBjwFh+taIlwmGnamvtExGwAMCZvrKk/PGGb4FGn7SoKJRuZ+XOV7DHhthNS1u3jX6AHj445SGl+Ak6D1jOknc2itG9KJeKsCgIn8GAK9pqg5g6cXN46OWh9uDOQFY4XfCKdIZhRAsmWto80D+rIcTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726837000; c=relaxed/simple;
	bh=b2BNHTli2T+XYo31VzBHNvROD2f3KCpVxXvcSlsFvbk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=un/ygfqZXnuEKW5lgEvsjU0SPB3aS7C7F3iZbEl34FayDLzg1kItwOD+Lyek+7HnUqGfE8GB/48c95x0O/bgiO3M1QHJVMVgqU2/+hT03Hxvw35iTBX2X1RHn8VOzmlCHa6TYdzXh/JX4KqCQSwztbTMSYPBTuY9ywPqYCLVQlQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jIHx/5Yr; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5c46680a71bso663640a12.2
        for <linux-rdma@vger.kernel.org>; Fri, 20 Sep 2024 05:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1726836997; x=1727441797; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=b2BNHTli2T+XYo31VzBHNvROD2f3KCpVxXvcSlsFvbk=;
        b=jIHx/5YrRWfjV/ZnkjdLwRAWdR0FmPBQd8hZvqnA05k4VJINmmFz5u2hTNKqYt63Zb
         vnY5Eeff1CdTn6IuhmTSfGNBPFapOCl69O2fnFIuV8F0nLXqMA5w/Cbc3LVEAB7FALPK
         r5EZmtQX8PQsUZT78pDloCoUFhEuvEGSM4eHeRwzv7lUN2v4RWZ43d7vgVDuTQZs9Gh/
         +Yj18dqgqCoGcf9X4Y6YZuz+aQq+Y5M2j4rxD2HHShpjsqXuqKu6AyIx/CfklmPXBzgJ
         V3lSCksoURaNLQJz91dICSvoGgkmFNuLSIswQxpeMSC/cV/L39OkGPhz23uuqT+0yPAH
         zLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726836997; x=1727441797;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b2BNHTli2T+XYo31VzBHNvROD2f3KCpVxXvcSlsFvbk=;
        b=YMVdIFQstMROnQXaa4rh3PrW7Bxf6y0TIQdvJlHBLjuM/2nnA9xuvyLJJMihd64csN
         4qVhHCLR+zBorUEgUi8JIhi6qij2CVGx+SxIXT8xSw3kDuxHHqUWoHzm313oAcuqZzTZ
         s3XHGOXb0tsGT+0jnSLpiam4OCVN6k/yRkE9grFZyvHnlrzZcL0qVXV4r2tCqSNPG8VI
         l93qifPCsKPRPcpP+gafsrJU9IUk64zbfhq5A+UL6LaJhnRpena5traZMEbqCKIcqoC6
         tY5UcZpmtIWhAbYJ5YL5vbuizpKqW6bhHCOc636hquLE0+d7mZBttbjtm3gY9s/UxXJ+
         w89Q==
X-Forwarded-Encrypted: i=1; AJvYcCV2FvhR2H3ifhuNDW3WSzTv9wFVb5r5nuL4ApejZRUmLl7LAqDmnbrEPLdQsB92xBVmEWqPeYpxeUBx@vger.kernel.org
X-Gm-Message-State: AOJu0YwgYLL17pMLI9CImFI1uG8O+ViHUpMJxmxyA1BeU/1yfOImHFx0
	GM93H/EuUqFvzkpTq5dfHnj/LkIl7+XVQRbuNOwkjGnM+sIrtc59j9rW/bGQZrGDmoPHlldPFBo
	N
X-Google-Smtp-Source: AGHT+IHuUIfd4zLI4M598vLXeC2Dy3DyoweK2F0RvU1TECfflBdWOi68PKrP/lA98xxeG3CTXnsLag==
X-Received: by 2002:a05:6402:278b:b0:5c4:b33:1f with SMTP id 4fb4d7f45d1cf-5c464a56980mr1793950a12.28.1726836997095;
        Fri, 20 Sep 2024 05:56:37 -0700 (PDT)
Received: from ziepe.ca ([83.68.141.146])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c42bb5f2b6sm7188222a12.52.2024.09.20.05.56.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Sep 2024 05:56:36 -0700 (PDT)
Received: from jgg by jggl with local (Exim 4.95)
	(envelope-from <jgg@ziepe.ca>)
	id 1srdBb-0001BR-Qq;
	Fri, 20 Sep 2024 09:56:35 -0300
Date: Fri, 20 Sep 2024 09:56:35 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Selvin Xavier <selvin.xavier@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH v2 for-rc 0/6] RDMA/bnxt_re: Bug fixes for 6.12 kernel
Message-ID: <Zu1xA0WUVKpJerAw@ziepe.ca>
References: <1726715161-18941-1-git-send-email-selvin.xavier@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1726715161-18941-1-git-send-email-selvin.xavier@broadcom.com>

On Wed, Sep 18, 2024 at 08:05:55PM -0700, Selvin Xavier wrote:
> Few generic fixes in bnxt_re driver for 6.12 kernel.
> Please review and apply.

These will have to wait till the next rc1 due to the LPC conference..

Jason

