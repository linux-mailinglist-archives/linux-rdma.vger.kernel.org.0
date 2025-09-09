Return-Path: <linux-rdma+bounces-13195-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8182B4AC57
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 13:40:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19C841BC3EE6
	for <lists+linux-rdma@lfdr.de>; Tue,  9 Sep 2025 11:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618E6322A13;
	Tue,  9 Sep 2025 11:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YE3sGncy"
X-Original-To: linux-rdma@vger.kernel.org
Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFECF255F31;
	Tue,  9 Sep 2025 11:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757417983; cv=none; b=d2NDyLQ5XpIkONp4+EWHbdymhBfok4IObOYZv5eSaaEP51D6QA4vMoUtevz/984Tb2MSYOy++GXJSfvj+isLAyvAA2f2hU2vyp4Bx6X4Xx4wXFaVswQyjxMSJ/F6nEaK8ocs9KQJO6VF2fSVsrAJeHmcaP2q/lAfZI+FzaKACX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757417983; c=relaxed/simple;
	bh=2vPVGLuNg1awR+xeX85MRQK0GwqZk7QK0+n5jfOfVqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ePqCiaPtXeuMuF3w9juNyDHJQs/TeiU8oRgh0k9iEoGOj1ZStT65pJj5dMeqJqaGbX3w83eug0li6/rfcyMo5k2ByhyuviWZjlfxjAz2G7iLaAvFWluCCl5/syOfweSLtCYLYgVztiAqTO0ikbSjC865a4toQe3hTRIaYozM7tY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YE3sGncy; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1757417971; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=2vPVGLuNg1awR+xeX85MRQK0GwqZk7QK0+n5jfOfVqE=;
	b=YE3sGncysMk0oelbbahQEsjnhlGa/j/ZrnPtW9daUFgKsD9X+B/s17cEJJybsCLxJxOqwHzJfrDKWQ6r/f83IjJjy2Z9qhrqmHO6GGJ1tmR4PGbJo+oSiIFm2lXlnqNr8T5P3tdGHbgdl4RNJRd63GUcGMORT8234a4scZ+UoRo=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0Wndu0.e_1757417970 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 09 Sep 2025 19:39:30 +0800
Date: Tue, 9 Sep 2025 19:39:30 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Mahanta Jambigi <mjambigi@linux.ibm.com>, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, alibuda@linux.alibaba.com, sidraya@linux.ibm.com,
	wenjia@linux.ibm.com
Cc: pasic@linux.ibm.com, horms@kernel.org, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org
Subject: Re: [PATCH net] net/smc: Remove unused argument from 2 SMC functions
Message-ID: <aMAR8q4mc3Lhkovw@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250909071145.2440407-1-mjambigi@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250909071145.2440407-1-mjambigi@linux.ibm.com>

On 2025-09-09 09:11:45, Mahanta Jambigi wrote:
>The smc argument is not used in both smc_connect_ism_vlan_setup() &
>smc_connect_ism_vlan_cleanup(). Hence removing it.
>
>Fixes: 413498440e30 net/smc: add SMC-D support in af_smc

The standard format for the Fixes tag requires the title to be enclosed
in parentheses.

But I don't think this is a bugfix.


>Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
>Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>

Besides,
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>

Best regards,
Dust



