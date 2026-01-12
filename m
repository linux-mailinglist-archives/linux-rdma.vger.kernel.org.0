Return-Path: <linux-rdma+bounces-15478-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F9AD1437C
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 18:00:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD22630807C7
	for <lists+linux-rdma@lfdr.de>; Mon, 12 Jan 2026 16:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC43937416A;
	Mon, 12 Jan 2026 16:57:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ob96Ul8k"
X-Original-To: linux-rdma@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DBAF364036
	for <linux-rdma@vger.kernel.org>; Mon, 12 Jan 2026 16:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768237024; cv=none; b=ZCrcVd96iRYhEkP74yi6pvfGGPDHve/p1wt/VlDZ4QoGXFXWS/FAIsWxltUMvOHVTscJfWYSvVpiaKfSnhMU4JnNZRiL60Ubf0ktKODQgcmSGCut6m2FniImHaNSXWYlzZIehmX972g+Ldoy1O5SDOb64Z7hSjdC/8rSFK57M9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768237024; c=relaxed/simple;
	bh=ZVhUhDahJvVOMERR8LDJiAijzjP0a8psViuZ8vlZbKw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=U47ILlvSpRc98JvGjYuSSrzfji3pGwp+vm1BpEcTndLEEn7n664PheD4iIBxAiC5Fo92wC7hnAp9W9muZsmiZfOdBLrZMXZB0Ra2HYNExdTdWYDwNY7OZihL8zuH5crwMbL/3If6/5O9j3Tg2qh/jO1uRzilwm1YAcjz8yKPR2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ob96Ul8k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768237022;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c+ytZ1c/Ea9PPW16FUHxaZOlzDf1w43iH7iqICQbdK0=;
	b=Ob96Ul8k5l+HliUoooD0oSRbXd3hMh/+oam/fbohtZwASnfennwXFKmUMY5xg6ezxxMzMb
	r4qSucf9CnoWPVT4DrWJEauNB4fKZOTvJxgKgaw/hsWfMM8bqE11LLxphrr5OAoz61BqYH
	+BdQ9qOwAx686g5X62GPq6d9AJoUFZc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-481-Ugn58wkyN1CvtXd7CIAw1w-1; Mon,
 12 Jan 2026 11:56:57 -0500
X-MC-Unique: Ugn58wkyN1CvtXd7CIAw1w-1
X-Mimecast-MFC-AGG-ID: Ugn58wkyN1CvtXd7CIAw1w_1768237013
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6AA9E1800372;
	Mon, 12 Jan 2026 16:56:53 +0000 (UTC)
Received: from [10.44.34.128] (unknown [10.44.34.128])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8CDD030001A2;
	Mon, 12 Jan 2026 16:56:46 +0000 (UTC)
Message-ID: <97487370-0ef5-4324-87e9-c86668055314@redhat.com>
Date: Mon, 12 Jan 2026 17:56:45 +0100
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [PATCH net-next 06/12] dpll: Support dynamic
 pin index allocation
To: kernel test robot <lkp@intel.com>, netdev@vger.kernel.org
Cc: oe-kbuild-all@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>, Rob Herring <robh@kernel.org>,
 Leon Romanovsky <leon@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
 linux-rdma@vger.kernel.org, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
 intel-wired-lan@lists.osuosl.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, devicetree@vger.kernel.org,
 Conor Dooley <conor+dt@kernel.org>, Jiri Pirko <jiri@resnulli.us>,
 Richard Cochran <richardcochran@gmail.com>,
 Prathosh Satish <Prathosh.Satish@microchip.com>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, Mark Bloch <mbloch@nvidia.com>,
 linux-kernel@vger.kernel.org, Tariq Toukan <tariqt@nvidia.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>,
 Krzysztof Kozlowski <krzk@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>
References: <20260108182318.20935-7-ivecera@redhat.com>
 <202601122216.BCarSN6K-lkp@intel.com>
Content-Language: en-US
From: Ivan Vecera <ivecera@redhat.com>
In-Reply-To: <202601122216.BCarSN6K-lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4



On 1/12/26 4:13 PM, kernel test robot wrote:
> Hi Ivan,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Ivan-Vecera/dt-bindings-dpll-add-common-dpll-pin-consumer-schema/20260109-022618
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/20260108182318.20935-7-ivecera%40redhat.com
> patch subject: [Intel-wired-lan] [PATCH net-next 06/12] dpll: Support dynamic pin index allocation
> config: m68k-allmodconfig (https://download.01.org/0day-ci/archive/20260112/202601122216.BCarSN6K-lkp@intel.com/config)
> compiler: m68k-linux-gcc (GCC) 15.2.0
> reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260112/202601122216.BCarSN6K-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202601122216.BCarSN6K-lkp@intel.com/
> 
> All warnings (new ones prefixed by >>):
> 
>     drivers/dpll/dpll_core.c: In function 'dpll_pin_idx_free':
>>> drivers/dpll/dpll_core.c:499:28: warning: integer overflow in expression of type 'int' results in '-2147483648' [-Woverflow]
>       499 |         pin_idx -= INT_MAX + 1;
>           |                            ^
> 
> 
> vim +499 drivers/dpll/dpll_core.c
> 
>     490	
>     491	static void dpll_pin_idx_free(u32 pin_idx)
>     492	{
>     493		if (pin_idx <= INT_MAX)
>     494			return; /* Not a dynamic pin index */
>     495	
>     496		/* Map the index value from dynamic pin index range to IDA range and
>     497		 * free it.
>     498		 */
>   > 499		pin_idx -= INT_MAX + 1;

'pin_idx -= (u32)INT_MAX + 1' should be here..

Will fix.

I.
>     500		ida_free(&dpll_pin_idx_ida, pin_idx);
>     501	}
>     502	
> 


