Return-Path: <linux-rdma+bounces-18514-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eLViM6b+wGmiPQQAu9opvQ
	(envelope-from <linux-rdma+bounces-18514-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 09:49:42 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 467052EE761
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 09:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B4B0A301372F
	for <lists+linux-rdma@lfdr.de>; Mon, 23 Mar 2026 08:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5893137DEAE;
	Mon, 23 Mar 2026 08:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="q5yHBILY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qODxOPEn"
X-Original-To: linux-rdma@vger.kernel.org
Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41512AEE4;
	Mon, 23 Mar 2026 08:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774255775; cv=none; b=apnam3scDaDN9hR5xHcU6QI1x68gWBaMGNBBTYxKAF+/gvPRdWygpqAkalwf2ytedoYFnMhCCX10vjctWxA6ZKL5qRPXx6imao0C6yDnfJk3kZ3iiF6pEJh0vklQqtpnFhECZURvy80u7EEnWNdUIs87uh1zxKrMNA66ATP503I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774255775; c=relaxed/simple;
	bh=p9B9IgGH88HGmQ61xIwwmQEr8RIY/R3tOPjndnPplWo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=n8Sb78CvB2xkWi2CHcibl/K4Nzpe/turTDBbpZxJOTGkhxjjWNnUDxOzaXoUektEEQNhVe5sDHuHpmUifwPw3k0WQpGgxDgZkvEGGsE/66ROAMzLcmh8oZV3EjzihK8Fz58R7A16EAKn4c8b64FT1SlTJ41K8JXFOEh+V4XrChE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=q5yHBILY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qODxOPEn; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id ED0C1EC01D5;
	Mon, 23 Mar 2026 04:49:32 -0400 (EDT)
Received: from phl-imap-02 ([10.202.2.81])
  by phl-compute-04.internal (MEProxy); Mon, 23 Mar 2026 04:49:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1774255772;
	 x=1774342172; bh=tdJCIcUWditaxcgxgFlEFsn2IU+LFbGTMnX6JWZKdXk=; b=
	q5yHBILYNTaEj0UGHrUmAVH4w1rePRf4dMjJnjHJIgqCe65RtIHEoyGaqnckTkgm
	A4UcGDFBgODFKfnYh+5ZmISGd7kUEX9nfN+2yLceV80VzkaEIy40Eiz6CmrUFZRK
	xIRMItES/zizM6T3Mi+KV3C+l0IMsdn8QwAJA49Ac1HFXQ5JoJHWoe+MKhs3zPgQ
	+Bf0Jn+SdtcqZ9OKNTZXn4u4elYtFWySYTZ9DeokaWy0s0NghroxBITWdPn2Vvjn
	vxOjIyyDA32cj9oIwk8j2zP1opyQ9UdbV92FF31JchQCxaNxGT+IJkgXk3/BvOfL
	T7/bfYLKJ6apIA1jP91rtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774255772; x=
	1774342172; bh=tdJCIcUWditaxcgxgFlEFsn2IU+LFbGTMnX6JWZKdXk=; b=q
	ODxOPEnx2VlBZaEVPGjZw+T94REgQ60c2KcRLew88db3/pAF/8MWmYy/s1MaCW++
	+sYaRgyIDskk/ZfhKtIszcsccCZnBmdf4QyUgNB8AHVftvLiNjbxpGCRl5bOuL0Z
	HL28paWI83IC3CHq0lOwbQqwNwdu7u5vEeSG2o3xg4iX6FKTwj9pW5eynAXNRv/J
	iWlxsY4GLzd25EJ4QHMBPgBgKcyakVUu9Yxlm14VY0RBZElZzh5RRqIotZBVKN58
	AZrBYnEFxFw8PjzD/G7c2ZMGb9peWvIg/htDwIHdDPZzpX5x9FkpOvptRhTSWYI5
	hYun3QeHE17t1YB9n/Wfg==
X-ME-Sender: <xms:nP7AaXgCW44O4HbHcYOmy9r91A9rd96zPpfpU5iLZ4vPjLItg_3Big>
    <xme:nP7Aae2wJpNdvkEzqat9dUhZPG-iWZ1SODv8NTWGwxNmg4utdS3kYGmEFVlQyKW3V
    k85UDNprOc0_doUEXR54r-na3IM4Ll3pHNSUDNqqnU2EMx2JX0PMhE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefudekvdejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedftehrnhgu
    uceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrthhtvg
    hrnhepfefhheetffduvdfgieeghfejtedvkeetkeejfeekkeelffejteevvdeghffhiefh
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpegrrhhnugesrghrnhgusgdruggvpdhnsggprhgt
    phhtthhopeduiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepuggvnhhnihhsrd
    gurghlvghsshgrnhgurhhosegtohhrnhgvlhhishhnvghtfihorhhkshdrtghomhdprhgt
    phhtthhopehnihgtkhdruggvshgruhhlnhhivghrshdolhhkmhhlsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepjhhushhtihhnshhtihhtthesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepmhhorhgsohesghhoohhglhgvrdgtohhmpdhrtghpthhtohepmhhitghhrggvlh
    drjhdrrhhuhhhlsehinhhtvghlrdgtohhmpdhrtghpthhtohepmhhikhgvrdhmrghrtghi
    nhhishiihihnsehinhhtvghlrdgtohhmpdhrtghpthhtoheprghrnhgusehkvghrnhgvlh
    drohhrghdprhgtphhtthhopehlvghonheskhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    mhhinhhgoheskhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:nP7AaVNF3zMRqm3avsSVqs1btmQwy8tGvVBLS7OyiMAbPTlGM11G2w>
    <xmx:nP7AaWdUY3C08mKej00puu-9Dsxdys9w5teXuB-UqLJeHwUdua64AQ>
    <xmx:nP7AabGVD682BrGBaxmbqosdgmpX9Ds-9XILB4zVwGGzx3vSJLvNYg>
    <xmx:nP7AaRsOstikJQAIuoEyINEAoZA2y4UMKkmrSkq5R0FVGy2y4o7G_A>
    <xmx:nP7AaXSrwpvqumCY4WS_qRiYv76aPdUieW6moF1IntnxmroNveBREDBm>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id E1BE6700065; Mon, 23 Mar 2026 04:49:31 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AhovTUn8f-P3
Date: Mon, 23 Mar 2026 09:48:59 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Leon Romanovsky" <leon@kernel.org>
Cc: "Arnd Bergmann" <arnd@kernel.org>,
 "Dennis Dalessandro" <dennis.dalessandro@cornelisnetworks.com>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Nathan Chancellor" <nathan@kernel.org>,
 "Mike Marciniszyn" <mike.marciniszyn@intel.com>,
 "Michael J. Ruhl" <michael.j.ruhl@intel.com>,
 "Doug Ledford" <dledford@redhat.com>,
 "Nick Desaulniers" <nick.desaulniers+lkml@gmail.com>,
 "Bill Wendling" <morbo@google.com>, "Justin Stitt" <justinstitt@google.com>,
 "Marco Crivellari" <marco.crivellari@suse.com>,
 "Ingo Molnar" <mingo@kernel.org>, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Message-Id: <5d5f25fc-e522-4131-ae4b-22db57b92d6e@app.fastmail.com>
In-Reply-To: <20260323080848.GF814676@unreal>
References: <20260320151511.3420818-1-arnd@kernel.org>
 <20260320151511.3420818-2-arnd@kernel.org>
 <6b56c476-86fd-4d43-8dee-c7f89d346941@app.fastmail.com>
 <20260323080848.GF814676@unreal>
Subject: Re: [PATCH 2/3] RDMA/hfi1, rdmavt: open-code rvt_set_ibdev_name()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arndb.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[arndb.de:s=fm1,messagingengine.com:s=fm1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-18514-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[kernel.org,cornelisnetworks.com,ziepe.ca,intel.com,redhat.com,gmail.com,google.com,suse.com,vger.kernel.org,lists.linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@arndb.de,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[arndb.de:+,messagingengine.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma,lkml];
	NEURAL_HAM(-0.00)[-0.975];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[messagingengine.com:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,app.fastmail.com:mid]
X-Rspamd-Queue-Id: 467052EE761
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Mar 23, 2026, at 09:08, Leon Romanovsky wrote:
> On Fri, Mar 20, 2026 at 04:53:04PM +0100, Arnd Bergmann wrote:
>> On Fri, Mar 20, 2026, at 16:12, Arnd Bergmann wrote:
>> 
>> > +	 */
>> > +	ibdev = &dd->verbs_dev.rdi.ibdev;
>> > +	dev_set_name(&ibdev->dev, "%s_%d", class_name(), dd->unit);
>> > +	strscpy(&ibdev->name, dev_name(&ibdev->dev), IB_DEVICE_NAME_MAX);
>> > +
>> 
>> I messed this up during a rebase, that should have been 
>> 
>>        strscpy(ibdev->name, dev_name(&ibdev->dev), IB_DEVICE_NAME_MAX);
>> 
>> (without the extra &). I'll wait for comments before resending.
>
> The hfi1 driver is scheduled for removal. Dennis has already posted the
> hfi2 driver, which serves as its replacement.

Ok, that does sound like a sensible decision, and I'll just drop
patches 1 and 3 then, which are just cleanups.

The cover letter at [1] suggests that the two drivers will still
coexist for a bit though, so I think we'd still want patch 2/3
in order to get a clean 'allmodconfig' build when the 
-Wmissing-format-attribute is enabled by defaultt. I have a couple
of patches in flight.

I took a quick look at the hfi2 driver, and noticed a few things
that that may be worth addressing before it gets merged, mostly
stuff copied from hfi1:

- A few global functions with questionable namespacing:
  user_event_ack, ctxt_reset, iowait_init, register_pinning_interface,
  sc_{alloc,free,enable,disable}, pio_copy, acquire_hw_mutex,
  load_firmware, cap_mask.
  It would make sense to prefix all global identifiers with 'hfi2_',
  both out of principle, and to allow building hfi1 and hfi2 into
  an allyesconfig kernel without link failures.

- The use of INFINIBAND_RDMAVT seems unnecessary: right now
  this is only used by hfi1, now shared with hfi2 but later to
  be exclusive to the latter. Since it is unlikely to ever
  be used by another driver again, this may be a good time
  to drop the abstraction again and integrate it all into
  hfi2, with the old version getting dropped along with hfi1.

- The pio_copy() function is particularly slow since it uses
  the full-barrier version of writeq() in a tight loop,
  this should probably use __iowrite64_copy() etc to make it
  work better on arm64 and other architectures

- The use of bitfields in drivers/infiniband/hw/hfi2/cport.h
  makes the structures nonportable especially for big-endian
  targets, if those describe device interfaces. Similarly
  the use of __packed attributes in the same file seems
  arbitrary and inconsistent, to the point where it
  is likely to cause more harm than it can help. E.g.
  in

+struct ib_cc_table_entry_shadow {
+	u16 entry; /* shift:2, multiplier:14 */
+};
+
>
+struct ib_cc_table_attr_shadow {
+	u16 ccti_limit; /* max CCTI for cc table */
+	struct ib_cc_table_entry_shadow ccti_entries[IB_CCT_ENTRIES];
+} __packed;

  the outer structure is unaligned while the inner one requires
  alignment.


     Arnd

[1] https://lore.kernel.org/all/177325138778.57064.8330693913074464417.stgit@awdrv-04.cornelisnetworks.com/

