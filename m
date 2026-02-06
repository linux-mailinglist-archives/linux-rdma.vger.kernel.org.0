Return-Path: <linux-rdma+bounces-16652-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMwdBVn7hWmzIwQAu9opvQ
	(envelope-from <linux-rdma+bounces-16652-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 15:31:53 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CE54FEFBC
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Feb 2026 15:31:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA2C9300DF75
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Feb 2026 14:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F993EFD05;
	Fri,  6 Feb 2026 14:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="jAgHRIWP"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C36624BBF0
	for <linux-rdma@vger.kernel.org>; Fri,  6 Feb 2026 14:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770388013; cv=none; b=GO6f2VfHL2hsMdqO8Hpl4o5oogf/mY9KGVXRC1lF3LYnhrjuphbqvl4cESbpR6gpaEecP894dixTDUiAT0DoIKkYG9kb4OfTKmlxOhq4+6SJ72fgttdRUlsJwe+WWWJmhd6uydhi9yCJbuuYgEPxNkqQgIB0E7Van6OJABK3hfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770388013; c=relaxed/simple;
	bh=kB3H9AUUuhX4BIKWBbJC4pfF5h/befjCMDLXshDETlQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m8VTOboSUDYnFfRvBm89HxShNFpvFJ/AItDloAidbrSbIhzPnMAM2MSl6xg/ueCUITVImbY0umaxa0ryobjbFGUvCxKE0hbmzr4leJ8Djw15ZdJkc1h5eFpmbM/c5cGVghreLfza+TeLETZn87N34Bw5+FlLjYXf/71jw9g/oxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=jAgHRIWP; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8c711959442so265161385a.0
        for <linux-rdma@vger.kernel.org>; Fri, 06 Feb 2026 06:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1770388012; x=1770992812; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kB3H9AUUuhX4BIKWBbJC4pfF5h/befjCMDLXshDETlQ=;
        b=jAgHRIWPaTQO4L2S8d4rfymLWtEPShx8tkFJtX2ocWTbsdA7bdre3S2IyFYJsHt482
         dil+B0lDAB1XdXmo9IKaOutfLYPyOzcOOY1MAdTLaxdc/KXF7txksKpqruxILtlitB/N
         o28LC5BMDTRGHCiPXbblrYw/YGbf1KXWrwfz5NEA2mI46yykB0jbgMQX4N1vLN7SHF5h
         ez8dYHv9DeaG78IXdK2lJkHbvsn3TjunRWSfwVZB+KzJK5x/iqFuvfkB1JnpPyDzvO6B
         rQ0Tj6eP8VKKUZxllFqMSC/u6YJ7g+VupRwKIQUbIotVVCPWC53C4IP1OfozL/8qXNom
         BD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770388012; x=1770992812;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kB3H9AUUuhX4BIKWBbJC4pfF5h/befjCMDLXshDETlQ=;
        b=wkhk2D+h+x4+gLtaOtcjY7c/F/hcXTdD/LY+NVKGRj7dXlDGRAkiL+NT8oTAlflTwB
         5jXb54v2dRnECxUJSeaemKFqnne79MZJKku1x0KqVwq368ziGrM2Uqs4vAIraZf9Yd6h
         lwJY/VkC9Ds3hTfsCvUwo7+yNpRlqxfkt6/6afCV66XLARlp9ZNncHXSK0tqJZXxbYgz
         JVRGh52RNHtF/toCyh56oVO1X5L0gFTJUHuSM2YCzgIQ1p4XVThK6aUXRMhMxFyUN8oa
         FyIA+h7oq4Yc1owNwtDdeD4jy8T6lQp03nIl16VwW291jpk0QpUO8k9L9OHNSd/npQ79
         LCHw==
X-Forwarded-Encrypted: i=1; AJvYcCXhUj4Msu5F8L7zJDQvhF3/jqCyKmtqdEpyI4iDIZkdeYkwpbQ8BNp3+fua3xIWMRLGBxscw2mz7kku@vger.kernel.org
X-Gm-Message-State: AOJu0YzxDfMeRbdrgNn8AQJRNy1nHy43pRpuWOxqvsRzIFgAdg+Tok6j
	FN+JAg8DnnjSGBQygbzmZqM+aRFVC9UVMEIilW2aUnn7c4swsF0aFOfOScgPOeX0jNU=
X-Gm-Gg: AZuq6aJGHT3Na96Lzzq+0Ymu5BxBBRJ7OrJvWu6064csNEv5XRPLlFEzp9DbX33dv1y
	TgMEXGj1fERD+afaMBLPAAhB3TtlQ84khjAI5AgngH62Z1UcAqIG57K3tYGc29ogYe9LLAaNs1w
	YPtFeWHUzMob82YSKFqrqWvxFjTxl45DEUs0rIjBqi5Y/kVwfOUSvEoxsDqKQlqfCm6+O2SUoBS
	xL0CJ94sFVQ5Jsbyrx5xqHW7ce/5S4cU/fUvGsOdMhn85W0f2zVfZ3nJbOjsJXmKp95qnIFF5/p
	Chgr3S4iCis5ccSWKN4sjPAT8FMR4EGlthU8Jvb1xREtukmDnO4Bq6otsg+diHaailbgcChUrEm
	glNIHA8Oi4AqScrw95VzG/39qlqrNAeedaj3bmZN09xFD1Uu1h7sYXJzY4gN0NeX27F8wfsBiMW
	eptRzoBIg9vG4Ml3MXjQEIs1Gp5Lp4EVxAkxlHmSkjAS3E+eH+cSavGHyZgR/L7fwfmDM=
X-Received: by 2002:a05:620a:4005:b0:8c7:1271:f336 with SMTP id af79cd13be357-8ca40b65b93mr822196585a.2.1770388012552;
        Fri, 06 Feb 2026 06:26:52 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-112-119.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.112.119])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8953bf35710sm18490856d6.1.2026.02.06.06.26.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 06:26:51 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1voMnL-00000008NCF-1bgr;
	Fri, 06 Feb 2026 10:26:51 -0400
Date: Fri, 6 Feb 2026 10:26:51 -0400
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Cc: leon@kernel.org, linux-rdma@vger.kernel.org,
	andrew.gospodarek@broadcom.com, selvin.xavier@broadcom.com,
	kalesh-anakkur.purayil@broadcom.com
Subject: Re: [PATCH rdma-next v10 6/6] RDMA/bnxt_re: Direct Verbs: Support QP
 verbs
Message-ID: <20260206142651.GG943673@ziepe.ca>
References: <20260203050049.171026-1-sriharsha.basavapatna@broadcom.com>
 <20260203050049.171026-7-sriharsha.basavapatna@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203050049.171026-7-sriharsha.basavapatna@broadcom.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-16652-lists,linux-rdma=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,linux-rdma@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-rdma];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5CE54FEFBC
X-Rspamd-Action: no action

On Tue, Feb 03, 2026 at 10:30:49AM +0530, Sriharsha Basavapatna wrote:
> The following Direct Verbs have been implemented, by enhancing the
> driver specific udata in existing verbs.

Same general remarks here as for CQ. Don't introduce a "DV" idea,
split out adding umem from the other stuff, make it fully general so
that umem works on all QP types, and integrate the new parameters
directly into the normal flow.

Clearly explain what the new uapi parameters are for and why they are
needed. I didn't try to guess if they overlap attrs but they look
questionable like CQ's were.

Every one of these version I've looked at seems to have unjustified
junk in the uAPI - this is something your team needs to take
seriously, a clean uAPI design is essential to having a maintainable
driver.

Jason

