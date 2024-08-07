Return-Path: <linux-rdma+bounces-4225-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD2C9949CAE
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2024 02:13:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C0561F2121F
	for <lists+linux-rdma@lfdr.de>; Wed,  7 Aug 2024 00:13:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 055A510E4;
	Wed,  7 Aug 2024 00:13:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="pdw2tj/1";
	dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b="IquJ2VbS"
X-Original-To: linux-rdma@vger.kernel.org
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [96.44.175.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC40F163;
	Wed,  7 Aug 2024 00:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=96.44.175.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722989608; cv=none; b=UJtLoNooY6/Yn430vbrwWIxeBiv9Oaqvsug30bM3dtFFRe8Rhe8+SREaiFtS2zNuSj6xn3y78F+4mFqfWneRqbhftKg7/zHqeMNtw3Ex3ZexWMXtqEUo2Jm98+kc9mAQolmWl0V/CP3fLcbmXRI9/10FDZ8UrZVDPIOhI3pglw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722989608; c=relaxed/simple;
	bh=pWY8kLMzQJ5yjAJwQI9LxYd4wKj8auV2/jFjArIg7Sk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=MXgdpIWA/sUBqHc+9u+6+u3jGf7XqFU3BEF3GGO9YfOKK18EA3Z5ubbxsKkQiY0rR/sXz3zhtWSxdKsCc4Bk3kIoxQ4pnSaatBCrf9B1mudrPOdABmwU4PFyGcMaa6ylmFOc05Agzn+ZKpA4bTTSkkn1YmMG6sPTVigooYYhgaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com; spf=pass smtp.mailfrom=HansenPartnership.com; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=pdw2tj/1; dkim=pass (1024-bit key) header.d=hansenpartnership.com header.i=@hansenpartnership.com header.b=IquJ2VbS; arc=none smtp.client-ip=96.44.175.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=HansenPartnership.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=HansenPartnership.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722989605;
	bh=pWY8kLMzQJ5yjAJwQI9LxYd4wKj8auV2/jFjArIg7Sk=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:From;
	b=pdw2tj/1Fqd0lo2/wI3FAzaTYDdFobrvoVdwcI1d7IbuClBo1cYy835n3aGr5kreW
	 RsrXWszgfsLcMbNgc2XxNLTAo3BV8tDkLmEDCy6PouOj6KFKBCCqPsNCYJzvOyFNrf
	 kOeGoeTCgXq/E7GbBBfB2epRNFdG0u5L/a8m6cPE=
Received: from localhost (localhost [127.0.0.1])
	by bedivere.hansenpartnership.com (Postfix) with ESMTP id 1D4DA1281E30;
	Tue, 06 Aug 2024 20:13:25 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id u4ZFp3uHMyH6; Tue,  6 Aug 2024 20:13:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
	d=hansenpartnership.com; s=20151216; t=1722989604;
	bh=pWY8kLMzQJ5yjAJwQI9LxYd4wKj8auV2/jFjArIg7Sk=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:From;
	b=IquJ2VbSdCmnoW7UZVKs1NB9r3MqBX1tc+w7wOycpGwFb1VY228YEUOPaasj8uJCT
	 p3KyuLMt6wMFQ7WUjoQu+J8syo7Q4HJ+AQJRQhfR0p/ee6hxAy9ZpEAw5Os1QQxLEL
	 iUIApDFpQ8QjjqzlQxQ059GsNBOoT3w1PRnmKjt0=
Received: from [127.0.0.1] (wsip-70-191-149-15.dc.dc.cox.net [70.191.149.15])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 546B012806C0;
	Tue, 06 Aug 2024 20:13:24 -0400 (EDT)
Date: Tue, 06 Aug 2024 20:13:18 -0400
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: Dan Williams <dan.j.williams@intel.com>, Jason Gunthorpe <jgg@nvidia.com>
CC: Greg KH <gregkh@linuxfoundation.org>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
 ksummit@lists.linux.dev, linux-cxl@vger.kernel.org,
 linux-rdma@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [MAINTAINERS SUMMIT] Device Passthrough Considered Harmful?
User-Agent: K-9 Mail for Android
In-Reply-To: <66b2ba7150128_c1448294fe@dwillia2-xfh.jf.intel.com.notmuch>
References: <668c67a324609_ed99294c0@dwillia2-xfh.jf.intel.com.notmuch> <20240726142731.GG28621@pendragon.ideasonboard.com> <66a43c48cb6cc_200582942d@dwillia2-mobl3.amr.corp.intel.com.notmuch> <20240728111826.GA30973@pendragon.ideasonboard.com> <2024072802-amendable-unwatched-e656@gregkh> <2b4f6ef3fc8e9babf3398ed4a301c2e4964b9e4a.camel@HansenPartnership.com> <2024072909-stopwatch-quartet-b65c@gregkh> <206bf94bb2eb7ca701ffff0d9d45e27a8b8caed3.camel@HansenPartnership.com> <20240801144149.GO3371438@nvidia.com> <66b2ba7150128_c1448294fe@dwillia2-xfh.jf.intel.com.notmuch>
Message-ID: <328C1186-268E-49E9-A31C-40BFF9554C49@HansenPartnership.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On August 6, 2024 8:06:09 PM EDT, Dan Williams <dan=2Ej=2Ewilliams@intel=2E=
com> wrote:
>Jason Gunthorpe wrote:
>> On Wed, Jul 31, 2024 at 08:33:36AM -0400, James Bottomley wrote:
>>=20
>> > For the specific issue of discussing fwctl, the Plumbers session woul=
d
>> > be better because it can likely gather all interested parties=2E
>>=20
>> Keep in mind fwctl is already at the end of a long journey of
>> conference discussions and talks spanning 3 years back now=2E It now
>> represents the generalized consensus between multiple driver
>> maintainers for at least one side of the debate=2E
>>=20
>> There was also a fwctl presentation at netdev conf a few weeks ago=2E
>>=20
>> In as far as the cross-subsystem NAK, I don't expect more discussion
>> to result in any change to people's opinions=2E RDMA side will continue
>> to want access to the shared device FW, and netdev side will continue
>> to want to deny access to the shared device FW=2E
>
>As I mentioned before, this is what I hoped to mediate=2E The on-list
>discussion has seem to hit a deficit of trust roadblock, not a deficit
>of technical merit=2E
>
>All I can say is the discussion is worth a try=2E With respect to a
>precedent for a stalemate moving forward, I point to the MGLRU example=2E
>That proposal had all of the technical merit on the list, but was not
>making any clear progress to being merged=2E It was interesting to watch
>that all thaw in real time at LSF/MM (2022) where in person
>collaboration yielded strategy concessions, and mutual understanding
>that email was never going to produce=2E

Well, plumbers stands ready=2E  We're out of A/V rooms, but if you can do =
your own A/V with one of the owl cameras we can do a BoF session that can b=
e open to remote participants as well=2E  I'll be happy to do the setup=2E

Regards,

James

--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E

