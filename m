Return-Path: <linux-rdma+bounces-13030-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F238B3F634
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 09:08:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE56B1891693
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Sep 2025 07:09:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A5B72E613B;
	Tue,  2 Sep 2025 07:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EDq2ptt9"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC8111E868;
	Tue,  2 Sep 2025 07:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756796917; cv=none; b=VJWSPpFIWPHcaXAVNI+EenZ9GX3YIUe2qrwZ6UiKqd17ZvrstW9X0N8EBqpuCNRslYqS3UyldpW44/CjafuLS0MaRwnKFAnTElL/9S10G9q+Lr4EEjBOxSlhuragGy2ByBVJlC4sDJ5Pi80FCBYRC2q8HGQmLOS0pNwHYr4THz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756796917; c=relaxed/simple;
	bh=t5rO2T8mcpV/W/74JNv+yoltgjj6T30b4Yx8Qdk4rr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g70yucsmPriaXvlZeXbjXGPdCR41O9KKKnket/Ce8P52H9sqLCnjnW/5NHNLvbm8tgi+NoWR2C/50oggMW/liapBGHuCncvqMpDKWWZ1g8EqCOfA8SnRyAhQdHHCNExT1rMo2BbIc655EkndCPASA8o0ETkTAnsVT/oVWkIscwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EDq2ptt9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A84C4CEED;
	Tue,  2 Sep 2025 07:08:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756796917;
	bh=t5rO2T8mcpV/W/74JNv+yoltgjj6T30b4Yx8Qdk4rr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EDq2ptt9neIjVNygJczFJMZ0xpN43oztKUqeih3z+EM44a+t1R5VuXd83SWlPETBl
	 Go9x91sIMJqVUXWFyLUghS4hAjn+oU/4RuycMbbx8TcpWE1x6+Z4AJprmUNy0CdHow
	 /Zz6cuvAsBoPpbaczXv5G0q4r9iiGlnn7E+vAVxyH3KZm6/SXKIzTwWKakrhbxQypN
	 OiYoovWE4KBtd69xQSJ+8p89I+rc7zUnYfL/Puve/hm2iFXLZeQXU/IdksAdzTB3Gn
	 pY1leSKxEo3cAbxRdJ0qK5psMq4hcCTKMTJYMWtZIcnTYQl5VhxnBS3LfE2t0aIzDD
	 MKh4djt661TUQ==
Date: Tue, 2 Sep 2025 08:08:31 +0100
From: Simon Horman <horms@kernel.org>
To: Mahanta Jambigi <mjambigi@linux.ibm.com>
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com, sidraya@linux.ibm.com,
	wenjia@linux.ibm.com, pasic@linux.ibm.com, tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-rdma@vger.kernel.org,
	Alexandra Winter <wintera@linux.ibm.com>
Subject: Re: [PATCH net] net/smc: Remove validation of reserved bits in CLC
 Decline message
Message-ID: <20250902070831.GA168966@horms.kernel.org>
References: <20250829102626.3271637-1-mjambigi@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250829102626.3271637-1-mjambigi@linux.ibm.com>

On Fri, Aug 29, 2025 at 12:26:26PM +0200, Mahanta Jambigi wrote:
> Currently SMC code is validating the reserved bits while parsing the incoming
> CLC decline message & when this validation fails, its treated as a protocol
> error. As a result, the SMC connection is terminated instead of falling back to
> TCP. As per RFC7609[1] specs we shouldn't be validating the reserved bits that
> is part of CLC message. This patch fixes this issue.
> 
> CLC Decline message format can viewed here[2].
> 
> [1] https://datatracker.ietf.org/doc/html/rfc7609#page-92
> [2] https://datatracker.ietf.org/doc/html/rfc7609#page-105
> 
> Fixes: 8ade200(net/smc: add v2 format of CLC decline message)
> 

Hi Mahanta,

Sorry to nit-pick, but there should not be a blank line here.
And the correct format for the Fixes tag, whith at least
12 characters of hash, is:

Fixes: 8ade200c269f ("net/smc: add v2 format of CLC decline message")

> Signed-off-by: Mahanta Jambigi <mjambigi@linux.ibm.com>
> Reference-ID: LTC214332

Please drop this non-standard tag.
And please only include references (by any means) to public information.

> Reviewed-by: Sidraya Jayagond <sidraya@linux.ibm.com>
> Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>

...

