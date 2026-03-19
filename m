Return-Path: <linux-rdma+bounces-18408-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aChpO8eMvGnz0QIAu9opvQ
	(envelope-from <linux-rdma+bounces-18408-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 00:54:47 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D6FE2D44CA
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2026 00:54:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1541030185F4
	for <lists+linux-rdma@lfdr.de>; Thu, 19 Mar 2026 23:54:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CFD3BED32;
	Thu, 19 Mar 2026 23:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oy3VHliM"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDC382989B5;
	Thu, 19 Mar 2026 23:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773964476; cv=none; b=U26bvj/wStJ9uxaGR5q2DaGC0thVzAz1Owxmx6KNnIj4Xj2xEBeWnt79fJ6UtVewRx/dIouayWBjf+ztTWk8OElm6ENNS/nfM8HwgyjqnJAHkqqmLFOeJZgGdFE+7fsxWJbhm2jR9HP2uQtwAS7QK9hiaqJp1KquqL1w561b/v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773964476; c=relaxed/simple;
	bh=NYxbVSAHM14rWliVEjZrDMJxKjuQDjiuCZ2YoV3tPCw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IFXQ5hSKLwBtUaD3GrWWlK+3cIsMOXQpaFV8oQGF3mdLkeHZ7e5JTSDxD/VLGn8CHQafWpgfzywn1KdGhln7gw6CQdXkfk98N4KMzLZmqNqLF+yOW2psEF/Xn4/z9bwHIhKZd9raZQiPWRxQGiRO/qRdNE5yLgYaCB21uHWN2nM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oy3VHliM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FACC19424;
	Thu, 19 Mar 2026 23:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773964476;
	bh=NYxbVSAHM14rWliVEjZrDMJxKjuQDjiuCZ2YoV3tPCw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Oy3VHliM9AiW+4rOP+iaK3hYr75033hq4fO7W6SGJo6F2TYVpJ2dp3adJuoA+22fy
	 8fmvCI9OT47OQbQPL4SCbpBLUSDnNTOrPROejZ7EqqiHBtVolUl8FgNDV9F+/XVpyo
	 eO2T6CPF3xFpc3HEeuzN6TX3/jAWdhtTN05UjnZ08DR9C5+rnwzgHd4x6IoIh2d61J
	 +7XBxIKNRop8rcLj0E1hvjqIwA1FwaEvKqvbxZaZ+zWX0mOQw/a6mJ+zt4NU6JqNyw
	 OhWxramAV93TbX1x422IZMaijLVeAHbUdAG0rWzkG8xKIe5DX2snVzenY4ux+UKaqa
	 zg5HYbx2n8oQw==
Date: Thu, 19 Mar 2026 16:54:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Allison Henderson <achender@kernel.org>
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org,
 pabeni@redhat.com, edumazet@google.com, rds-devel@oss.oracle.com,
 horms@kernel.org, linux-rdma@vger.kernel.org, allison.henderson@oracle.com
Subject: Re: [PATCH net-next v2 1/2] selftests: rds: add
 tools/testing/selftests/net/rds/config
Message-ID: <20260319165435.4468160f@kernel.org>
In-Reply-To: <20260319004618.2577324-2-achender@kernel.org>
References: <20260319004618.2577324-1-achender@kernel.org>
	<20260319004618.2577324-2-achender@kernel.org>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-18408-lists,linux-rdma=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[config.sh:url,include.sh:url,test.py:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1D6FE2D44CA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 18 Mar 2026 17:46:17 -0700 Allison Henderson wrote:
> --- a/tools/testing/selftests/net/rds/Makefile
> +++ b/tools/testing/selftests/net/rds/Makefile
> @@ -9,6 +9,7 @@ TEST_FILES := \
>  	include.sh \
>  	settings \
>  	test.py \
> +	config \
>  # end of TEST_FILES
>  
>  EXTRA_CLEAN := \
> diff --git a/tools/testing/selftests/net/rds/config b/tools/testing/selftests/net/rds/config
> new file mode 100644
> index 000000000000..103f9d941d10
> --- /dev/null
> +++ b/tools/testing/selftests/net/rds/config
> @@ -0,0 +1,5 @@
> +CONFIG_RDS=y
> +CONFIG_RDS_TCP=y
> +CONFIG_NET_NS=y
> +CONFIG_VETH=y
> +CONFIG_NET_SCH_NETEM=y

Contents of both these files need to be sorted according to the whims
of these scripts:
selftests: rds: add config file and config.sh -c option 

