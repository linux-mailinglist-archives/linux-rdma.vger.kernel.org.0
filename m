Return-Path: <linux-rdma+bounces-17497-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJ+7IP99qGluvAAAu9opvQ
	(envelope-from <linux-rdma+bounces-17497-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 19:46:23 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBCC206956
	for <lists+linux-rdma@lfdr.de>; Wed, 04 Mar 2026 19:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7C38F303B4D1
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Mar 2026 18:32:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811D63D567A;
	Wed,  4 Mar 2026 18:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V12EhCeI"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4134E351C1F;
	Wed,  4 Mar 2026 18:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772649134; cv=none; b=s/S7UIPBp9b6u+n1hDDwqP7rIoxJ/6pHccoYzT0++6rlxJRheAS4G7Y46O2QQHJm2s6jnm0Sez/m4fSPnjenv/1v5fXIZLn1fy0gDatxVj/VaOLxAQMC3ZWTOWtJXEnIe8E1yefCLE84eHmZSJsI7Z7x35h8TXgAI5X+aBFMUDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772649134; c=relaxed/simple;
	bh=RbTFD17uNGJoi0qLc1s2/l/+pUKnq4Xf6a4LHXhhb88=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AX5LI/uhnbvOx5QEvsh+WXH8Ad+09NHUHYz56drVw9P6tFbmnJBoxRVE/MaMeEJq5dw6mqofbu3xSR6d1KUYxzTcCtuf53hfbCNtmUFV3T9n6PRg5RON9gTgkLxKmzAYCa+euVjQXV9XMzJS3kZylTaTkPsb4bDjhhwUdo6XzVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V12EhCeI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE60FC4CEF7;
	Wed,  4 Mar 2026 18:32:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772649134;
	bh=RbTFD17uNGJoi0qLc1s2/l/+pUKnq4Xf6a4LHXhhb88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V12EhCeIPQjXKXsqXb1GBq/QE+6tHLLuXIH5t2gPgqbl6kYOHKclG60IMqvUhN5sW
	 li6IqWvB+fJlJsFHRx8kXX/oCw/1jkLuuqEdmk2VMsSpwVaBGCwfV2BxDdKMYXCnIw
	 b+RFbYlxJpxIc1essfJn4QbwGTAwaKN15BExcjpp3yWHB5w5rwhbIl5Lb3V15LjRfh
	 tYcH5MnUf/hC05zmaWQQSh58qV7w5DwfqOaXQAfMtikNqyNddKPFuo5V7OS71AlmUL
	 lCuQptInWE8xz3iZ5qKgLrn29G+H2Hp9KnX3Tg2DRS3m6ly5INHVCwcUaFR2QIuaI4
	 DbP84QuaK9Uow==
Date: Wed, 4 Mar 2026 10:32:12 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Allison Henderson <allison.henderson@oracle.com>
Cc: "achender@kernel.org" <achender@kernel.org>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>, "horms@kernel.org"
 <horms@kernel.org>, "edumazet@google.com" <edumazet@google.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "pabeni@redhat.com" <pabeni@redhat.com>
Subject: Re: [PATCH net-next v1 0/2] selftests: rds: refactor and expand rds
 selftests test
Message-ID: <20260304103212.2e7a58ba@kernel.org>
In-Reply-To: <18aa553886ee12855c28d9498b12d2fdaeee9b3c.camel@oracle.com>
References: <20260302055518.301620-1-achender@kernel.org>
	<20260302173302.4d1634be@kernel.org>
	<18aa553886ee12855c28d9498b12d2fdaeee9b3c.camel@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 2EBCC206956
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-17497-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.sh:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Wed, 4 Mar 2026 02:50:34 +0000 Allison Henderson wrote:
> I didnt know it was causing you grief, but I am happy to work with
> you to adapt it.  RDS is a little unique in that the network topology
> defines the underlying transport it uses.  If you were to run it with
> just a pair of veth interfaces on a single host or vm, then you will
> only be using the loop back transport in rds.ko.  In order to get it
> to load and test rds_tcp.ko, we need the endpoints to be in separate
> network namespaces so that the destination IP isn't seen as local. So
> the test case does this by forking server/client processes across
> name spaces.  There really isnt a rush on this series, so if you
> think we should do some refactoring/cleanup for ksft first that is
> fine.  Let me know your thoughts.

IIUC the need to set up a veth + 2 name spaces topology is very common.
We have bash "libraries" / helpers in various lib.sh files to do it.
Python libs also have some support (tho the default linking there is
by pairing two netdevsim devices).

Well, maybe to be clear I should say that we _even_ have support in
libraries for this. Not really strongly opposed to you rolling your own
way of setting up the namespaces at this point. I primarily care about
us being able to execute all your tests in our CI, with standard ksft
commands. Maybe I did something wrong but

 make -C tools/testing/selftests TARGETS=net/rds run_tests

did not work for me.

