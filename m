Return-Path: <linux-rdma+bounces-2735-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D87308D6859
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 19:45:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 769E7B26081
	for <lists+linux-rdma@lfdr.de>; Fri, 31 May 2024 17:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869B917B4F2;
	Fri, 31 May 2024 17:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VoWbjLoE"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008161E498;
	Fri, 31 May 2024 17:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717177539; cv=none; b=ulG9IM1d/RFaHVyHBIeatjv0mUYCLejNe+SfB6aUAablR/iIv8eIzGk0DIkNQFprLwyE70d/RRo4xjgOQTvfJitceEQYAg23guLhlYumAq1aSMNEsGYIPM0nBv56oK+y3zVc/XVpl8nrZnI1/0LsHBcTkFmG3Ae4VOfA+FoCaj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717177539; c=relaxed/simple;
	bh=8uonPPCIU7uZNQbdkZyb9jwo0cqAvt7xE/tAD1lP0ac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOh40BGW7osE3GrrbKFpQ9q+Mk6KyTRyeGpJtVS1QYxS16ymGJnz6uhDfGOy8AUF/4LLHhHaaAX047mEGtz5IHW/qreNdolX25PU/cFl3vgQ4G9+PkmmiGd8vFtqYMLYE6GpX/4NDEQl+AkWq0Zt9wYNlCvYTcY0cso/aOYTl78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VoWbjLoE; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-6c3b5c5e32cso711318a12.1;
        Fri, 31 May 2024 10:45:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717177537; x=1717782337; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q7HKazcb61yz9oY8O5HoJeBzR+SVYPCPLsjJ+eQygtI=;
        b=VoWbjLoEt8k/wehOvtbZsIkCNzEOSMRXRFSrpWx4DFq39hIkUwP1M9ZmDKeOBXT6/0
         Tv5c4A35ur+CHwhUQLTF3t1oq1TD3W7XHn5Ok88zcMvXbPSBsQ7+tHLcanNeB1kPo2a+
         DarDb85A40oGcJdMRPjh/5dbsPG+SJW2Q87yNYF6H4ipPRwHRG1IX/93qqM1vdSF6h72
         rk3TUqBVCT+I8A6/mTvr/uP9jqNNL0L/fGhGMQDgS+LhFSTdJcw6jmkox4u9Ho5uQWdd
         ZKauoOYaMHESPs3QnsItj+QyX7dBfY9c1SPBNnzDoGfwUZoklliLxptTUZpympwDpo1R
         skIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717177537; x=1717782337;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q7HKazcb61yz9oY8O5HoJeBzR+SVYPCPLsjJ+eQygtI=;
        b=bNGm9dpWRdOBNMpq0zKf+tPtcm0StJqpOvuXuatJMmRa0tKeVTZrF6szdMHNEViljp
         wcE6TPA/2p6cgsTi1Wove47xelz95edOYIUiFL05QrRiLOXTEcvIEjtjwC+BW1b5OpSR
         jzpStWnK9U34M5S0Yw1uzwo9CDUy5HQCcx80ZW5mPhGvL0G9xbvWIo81Mk5aBp78Gle8
         ddtPOSq9RmY0F6iSm+UxA/bx9txho0ALC++/1nI9A8ikxlQxIf4EnT9TZdVT3Em7Fx4/
         pY+caBUbVjVAJ/Og/6z3Xdtp6vsbf+XkDDYka/n0ExmjfYPqsvyy83T5jvJh2Gi1lk/h
         XuZw==
X-Forwarded-Encrypted: i=1; AJvYcCVxh8ihFrDQHaKDkUW6T1BuHEnGPIne3luEd3BGTzQOHoIX/L+88IiSi3RZHAyw85T45q8tetFFtiioRJmMQnkyoPNyRzCMUbwINo3oZ8zbeTf/HQoXu0C/2Zy3rKfPDPGmiUeSPj0NUA==
X-Gm-Message-State: AOJu0YzU4sEr2nkDDECLz2A1yDuLeGGlGHZEEaPpGxYqyDJRJ6o52XYo
	u6Yd4ZZ7F3OmIgPP9LtgOnzugdObFhiUccEymc2H+y2Qqka39VeV
X-Google-Smtp-Source: AGHT+IGKVEf3SggRRe7B4QoYHPNd1gQP0k1Loic9F6+cziMEQAW6QIzs+ebAlDz6APTEzDCec2g6sA==
X-Received: by 2002:a17:903:1112:b0:1f4:b2ce:8dbe with SMTP id d9443c01a7336-1f636fe892amr29376645ad.9.1717177537107;
        Fri, 31 May 2024 10:45:37 -0700 (PDT)
Received: from localhost (dhcp-141-239-159-203.hawaiiantel.net. [141.239.159.203])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f6323f76dcsm19331635ad.228.2024.05.31.10.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 10:45:36 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date: Fri, 31 May 2024 07:45:35 -1000
From: Tejun Heo <tj@kernel.org>
To: Leon Romanovsky <leon@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, linux-kernel@vger.kernel.org,
	Gal Pressman <gal@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>,
	RDMA mailing list <linux-rdma@vger.kernel.org>
Subject: Re: [PATCH -rc] workqueue: Reimplement UAF fix to avoid lockdep
 worning
Message-ID: <ZloMv29mmAKNPTrg@slm.duckdns.org>
References: <4c4f1fb769a609a61010cb6d884ab2841ef716d3.1716885172.git.leon@kernel.org>
 <ZljyqODpCD0_5-YD@slm.duckdns.org>
 <20240531034851.GF3884@unreal>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240531034851.GF3884@unreal>

Hello,

On Fri, May 31, 2024 at 06:48:51AM +0300, Leon Romanovsky wrote:
> We have similar issues but with different workqueue.

So, the problem with the proposed patch is that pwq may still be in use by
then (due to async freeing) and thus can't be freed immediately. I still
don't understand why KASAN is triggering there. I tried to repro by
introducing a pwq alloc failure but couldn't. Can you please share the
repro?

Thanks.

-- 
tejun

