Return-Path: <linux-rdma+bounces-17620-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qEdWIwk0q2n2agEAu9opvQ
	(envelope-from <linux-rdma+bounces-17620-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 21:07:37 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 06E6622769F
	for <lists+linux-rdma@lfdr.de>; Fri, 06 Mar 2026 21:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DF5A63040000
	for <lists+linux-rdma@lfdr.de>; Fri,  6 Mar 2026 20:07:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B8FD37647F;
	Fri,  6 Mar 2026 20:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/Y/k7cv"
X-Original-To: linux-rdma@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDD362E92BA;
	Fri,  6 Mar 2026 20:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772827649; cv=none; b=BB8OCyOiGM09kpv1M/IJGj9thjWY3AqFS3t5/HnqPwZIdJU/Ox7pdeZEb+aviux5BNZL/FOhT+3KmoMOk/wUiL24CQr/XDmdzJlt1dUKRYTsCtqG9GQBVOvlarRRi45k1eQeYpTCXKQmgDftjJ07lfsfu85JJqqw5eIwVqIcUjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772827649; c=relaxed/simple;
	bh=Dv+gHW+MLlcufFDt1KPtByGMul5N1wtpZhjbi+dJd8o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cOQkmzD/DerYzX6ECukLkvoaItRGQoz1DvLcbmf4Olpr0EEaChvXxHmgbndolIQIHTGec+FWcFTLoo6rCaqQpPYqSybDfvyoUZsEp6qlTHxEmcRRbtoqgVzad/kc5cs3iEjIXNR8XWYZu5axlKtdZW2G3T3MuNpF0EM7W4PWJGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/Y/k7cv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDDD2C4CEF7;
	Fri,  6 Mar 2026 20:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772827649;
	bh=Dv+gHW+MLlcufFDt1KPtByGMul5N1wtpZhjbi+dJd8o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V/Y/k7cvUM2saGS32xL2+jml1E17lBOV5tjhJSpnT3noMYZ+g7pEs6u68dRn+uttf
	 VU+cVxod++yrdkl4w3rvmB4FRu8eFthpNP+tPsKrfPfcLVPz0z618hf7+pU4QKyWAV
	 VjHnzu/UVVunasY7MMj7uiNuaU9qJQ08AjLRQDYt4BXmDs/ZT82X0l52JQ78TwbXRV
	 Ei3I2IPigdTUkZkxQB0hzX5b5pgYrj8HEuU+GwUHTN3oxjVTd3PAUzvmExNsh9qpHA
	 tIOOffEd8TBckCshOxOe6wscNfkKZr98ii6yxzxaVdb0Xhb1OapjidEMQot3bR0SbO
	 6C2YnYbxZ3P5A==
Date: Fri, 6 Mar 2026 12:07:28 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Allison Henderson <allison.henderson@oracle.com>
Cc: "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
 "rds-devel@oss.oracle.com" <rds-devel@oss.oracle.com>, "pabeni@redhat.com"
 <pabeni@redhat.com>, "horms@kernel.org" <horms@kernel.org>,
 "edumazet@google.com" <edumazet@google.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "achender@kernel.org" <achender@kernel.org>
Subject: Re: [PATCH net-next v1 0/2] selftests: rds: refactor and expand rds
 selftests test
Message-ID: <20260306120728.00fce23f@kernel.org>
In-Reply-To: <a2184a82a5fccc0b7bee91858ff4b3d0d37054ab.camel@oracle.com>
References: <20260302055518.301620-1-achender@kernel.org>
	<20260302173302.4d1634be@kernel.org>
	<18aa553886ee12855c28d9498b12d2fdaeee9b3c.camel@oracle.com>
	<20260304103212.2e7a58ba@kernel.org>
	<a2184a82a5fccc0b7bee91858ff4b3d0d37054ab.camel@oracle.com>
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 06E6622769F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-17620-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.935];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,linux-rdma@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lib.sh:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, 6 Mar 2026 07:43:56 +0000 Allison Henderson wrote:
> On Wed, 2026-03-04 at 10:32 -0800, Jakub Kicinski wrote:
> > On Wed, 4 Mar 2026 02:50:34 +0000 Allison Henderson wrote:  
> > > I didnt know it was causing you grief, but I am happy to work with
> > > you to adapt it.  RDS is a little unique in that the network topology
> > > defines the underlying transport it uses.  If you were to run it with
> > > just a pair of veth interfaces on a single host or vm, then you will
> > > only be using the loop back transport in rds.ko.  In order to get it
> > > to load and test rds_tcp.ko, we need the endpoints to be in separate
> > > network namespaces so that the destination IP isn't seen as local. So
> > > the test case does this by forking server/client processes across
> > > name spaces.  There really isnt a rush on this series, so if you
> > > think we should do some refactoring/cleanup for ksft first that is
> > > fine.  Let me know your thoughts.  
> > 
> > IIUC the need to set up a veth + 2 name spaces topology is very common.
> > We have bash "libraries" / helpers in various lib.sh files to do it.
> > Python libs also have some support (tho the default linking there is
> > by pairing two netdevsim devices).
> > 
> > Well, maybe to be clear I should say that we _even_ have support in
> > libraries for this. Not really strongly opposed to you rolling your own
> > way of setting up the namespaces at this point. I primarily care about
> > us being able to execute all your tests in our CI, with standard ksft
> > commands. Maybe I did something wrong but
> > 
> >  make -C tools/testing/selftests TARGETS=net/rds run_tests
> > 
> > did not work for me.  
> 
> Sure, lets get this fixed first then.  Usually when I run the test, I just run the one rds test directly like this:
> 
> vng --build  --config .config; vng -v --rwdir ./ --run . --user root --cpus 16 -- "export
> PYTHONPATH=tools/testing/selftests/net/; tools/testing/selftests/net/rds/run.sh" 2>&1 | tee outfile.txt;
> 
> I believe the way you run it would have it run directly on the host though.  Which can work but it would have to be
> built and configured correctly for rds. Also I think when run it through make run_tests, ksft may have other lib
> includes that get inherited by the child processes which can affect how they run.  But I'd like to see your output to
> confirm. Could you include the output you are seeing?  Then I'll see if I can recreate and address what you're seeing on
> my end. 

This is how we run:

https://github.com/linux-netdev/nipa/wiki/How-to-run-netdev-selftests-CI-style

Base system is Fedora 43 (since we use vng that's what the "VM" is
effectively also using). Please re-ask the questions that are still
relevant after you go thru the link above? I'm not sure what "run
directly on the host" means exactly ;) 

