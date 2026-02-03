Return-Path: <linux-rdma+bounces-16456-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNI3NiP9gWk7NQMAu9opvQ
	(envelope-from <linux-rdma+bounces-16456-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 14:50:27 +0100
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE05DA230
	for <lists+linux-rdma@lfdr.de>; Tue, 03 Feb 2026 14:50:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4DF943057490
	for <lists+linux-rdma@lfdr.de>; Tue,  3 Feb 2026 13:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88704350D55;
	Tue,  3 Feb 2026 13:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gnkjmZ8x"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yw1-f227.google.com (mail-yw1-f227.google.com [209.85.128.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6A1326948
	for <linux-rdma@vger.kernel.org>; Tue,  3 Feb 2026 13:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.227
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770126592; cv=pass; b=tVBZC62mak14SR6+H08iAPuMSY9x2RcogHf73X6zdg//bEypfcK243CMNmcakp+5uT4yujnDhv7qvc7WltU7EfQrLkwnabbtURWsJbB5LXmn0OgcAiiQ7W07w4+2+lseBqw7uJL/oddOQAv9IhBnQ4mWvIaRVlnx27uKdfSVCo8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770126592; c=relaxed/simple;
	bh=/YxBFws0Y5f7YV5I5OvwLKpq7ZazZGGwyh4XL6oIS00=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L4htptgQybHCpA5Hc84lP0TbD+JDEdL0WWqGU2uZVrSIph7cdVclKFb+Kqu6CJCZgEt30zQVD7Fdm1Iy3lYFaQyn8UcQZPnOEXiRfDj90XWD9cFH4mrbtF0mUT1MAwgMPbg4v7qYuZqDlwcs6tISvBhf9aWla6t8QphlBDexcLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gnkjmZ8x; arc=pass smtp.client-ip=209.85.128.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yw1-f227.google.com with SMTP id 00721157ae682-790884840baso53492877b3.0
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 05:49:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770126589; x=1770731389;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DiZ9qHjdN8yZngrrDlqF9/zfIqj4CH3PZudUWn1FpMs=;
        b=jFCtya0vgWZjXBx57LDQzt0h2cbmxN0Ldhc1BhHbHQbdRXnfdt0FmLAdBGl4mH1xqO
         YjMyVLZgLdDpFOVBnkJ7YhV1KWwT3hU1ZKUPvBWkTNiK1XPv5aPn0u5CjrD7Zn0WMmfy
         G8Wll/KQXigyWC+m0vdbx/wr7LRcYEmSPimmE25Px/4PGRVLtLmEPyYvQofwMXSPBFv0
         ODEy3F0pKtbxQDdGQlFSPrm4rQUUIeEUyeFfhHs8+Dk0aJOCaTxDD2XBwd4ehxRnVEBJ
         NhmWIpZqQ7iQb/dGNQMcg9At8rAlob3PHQMZUdJK0R14uCWSL9q1h4+s5w9kWTDuylJm
         wpeQ==
X-Forwarded-Encrypted: i=2; AJvYcCVZwtZpX87CvK7Lvy/kzqYmzt9KWBSdxnkl0Qm17V5K9aE7C/7y5y7WTxSOZL/vkMnJme2yfjVCUkNM@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5y+s/0QjndLIpAxdcAsOC1bPAZKWyJIR6ctfb/7q8RnBWndmg
	TNCfyMH8itYh6smaZfKVUP9xi2/BntZxJ4B6YRML4ARB8orL5WDDMStfdACEYu5ELARuQgh1h08
	VJdK0GTCsv36YmmoWBtC+DD1jPiSYUgfPUamuqv6e6CM1EU3Bz8fSsfmqiHa5TiMubY3SBrW8K3
	BnLKHWJnV0yUAbXey4t0uf4gvHG+FD3CmSXMd4nS1Jc7UG1NGQxqtwU/BpmhHf7qUXilElLzVeL
	BcwlkHNx+sdHknhwpg7rDWhwXb4
X-Gm-Gg: AZuq6aJlOnuTNTKYzIMRkkmBX6e7TrrKBA4nNZX1WKnLdss/Bx1xlACBXzN4oB5G4gR
	7Lbur3ELzXs4XcRDErXbEw+I1PrGw8snqEdDTL3G7Ao9W0HaRvLpDkX2KZD3K1AEMIvRxR+5mSG
	wzkTzvZUFiZGEQhETjw2vZLnxE3p9imUNGIxJDyM4oE3HMCHIuZgRVMsyBL/wYiSchTUYEncDHE
	TWdh8AFTjr/rZEBy72UUtqzmLr6wCkvz+sloGpFjnnMRIzIv3rG9WA+2oxVl6XRTFFRrtlCqzyz
	J6AbJVsxwVr+3Wicgvl4g1ASHJ6heD+9FrqM6kEuQrVkZ1ZkH7FTGK3Y6TE+/qT5ymUtXJqb0w+
	ajX9yU091RK1Zki0nW7p2qrPW2iur7Az+x/aQVeb5c3axArdce+UqeZ8/o1KqwxEgp4c6DPkjpk
	+jv6Rm9xMWln45h4QhbpzFtNSbES1bVMc/bTTVhxmTBatddqJhLfQT1g==
X-Received: by 2002:a05:690c:6b13:b0:794:1222:5b42 with SMTP id 00721157ae682-7949e05e90dmr129063247b3.67.1770126589166;
        Tue, 03 Feb 2026 05:49:49 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-0.dlp.protect.broadcom.com. [144.49.247.0])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-79482783f50sm11242507b3.1.2026.02.03.05.49.48
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Feb 2026 05:49:49 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-435db9425ebso5464424f8f.1
        for <linux-rdma@vger.kernel.org>; Tue, 03 Feb 2026 05:49:48 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770126587; cv=none;
        d=google.com; s=arc-20240605;
        b=OuCNJQYzJjYzAb7h2G7Ol9ObsvXjZzWjVN7b3HJV4PMmD1P3DFm+KDaFSg2hmGAIda
         b5E4m6FXDZUO2SonQbYQEOgxwdcBS+YHQaE75TxFq4KgJ3ShISJ+GPllw63GzYW+8zol
         UaerVcM273M9egeNLf0NFe9ak/qeBHYNqAUIslT+fOM3sk7uK+T8rtliw5+3CIP6Zm+L
         vC+UtFIKM1MMZzn9ygJ08ZZRQt7ZduWD3hLB4B+rq5aMOcU68xvuEcYYYmJIcIeqd8Mv
         5SyT9CUEb23NsHk0SajExnuJpon2jEhNvfsN8R9lsDmAiH68uhrOxOax52EYM165I21j
         tNMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=DiZ9qHjdN8yZngrrDlqF9/zfIqj4CH3PZudUWn1FpMs=;
        fh=hAopjrxwbVTCChIuuMeofJ/dcEumY0T3C9Sr+yPDLtk=;
        b=NsQ1ZB5k7fI3pRDlw2QqkyzUnd7aCr6EgzwdDht7lUPebPLPLao7Uuy9ad7Ln2vKL5
         IzpcZ0+lu955yLOSJo01tv0hnlh2MzzChV/QXHEy0a3KNU26jc5gtRTXzlpvVZvYbahR
         LkbzvNd56ELztjUKcnzgVrNRTN8eiWfPvV0AeEBbpOg4p3K3JZLx77vRy2ozQ3Q6QRX8
         aB8eTking4Heo2J4GMa0+BG+pZVtDj825vIaHzdRoAvsFGjkIp5SJA9sbiRiNzbDQ8KC
         EubtV50LtqNvhoC24v/Hajr9RTohxUYb4DoIhamiZJ7Hco5FlPuB6Zqp2PAC21tMx35v
         cg8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1770126587; x=1770731387; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DiZ9qHjdN8yZngrrDlqF9/zfIqj4CH3PZudUWn1FpMs=;
        b=gnkjmZ8xe0vn91FmpXMBwf+V2EhHWl9PLx2gFwi56TG3dAHm+f0oU/UyDxTx62r2WE
         PfqjuzCZXgzY7dKSMxnrfiHKKNHytpBH2DxNOD71da6A2znxUBbAGYg9HUlzUVHyF0iF
         NyY/nn/3ALrggxIHDRWIBoWYo7OZiVmF5P2xc=
X-Forwarded-Encrypted: i=1; AJvYcCUe3fEw9uVrrST6QPtLR2mPb5O2dkJzZoQ9smXqEvqrq1xU0/GCZEccqGjwXAlueCf+rxx5XLxhYkXJ@vger.kernel.org
X-Received: by 2002:a05:6000:2892:b0:435:9882:234e with SMTP id ffacd0b85a97d-435f3ad85d7mr19125579f8f.59.1770126586617;
        Tue, 03 Feb 2026 05:49:46 -0800 (PST)
X-Received: by 2002:a05:6000:2892:b0:435:9882:234e with SMTP id
 ffacd0b85a97d-435f3ad85d7mr19125548f8f.59.1770126586118; Tue, 03 Feb 2026
 05:49:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203085003.71184-1-jiri@resnulli.us> <20260203085003.71184-2-jiri@resnulli.us>
 <20260203100327.GS34749@unreal> <vw3hrr5fsamtsgydvydoewd4fnglas5xzickgfpjgp5y44gxkm@dmmvo36blqtb>
 <20260203122618.GT34749@unreal> <uixv7cu4qe5vqkl3dlsd4smbxvflo3syoseuwtf4v7xhwgziul@gqlnz4geufth>
 <20260203130335.GU34749@unreal> <56arliffs27lqgriymsnysnh672joz7ihndkeffqee32vvwxby@w6qhwezufrrc>
In-Reply-To: <56arliffs27lqgriymsnysnh672joz7ihndkeffqee32vvwxby@w6qhwezufrrc>
From: Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
Date: Tue, 3 Feb 2026 19:19:33 +0530
X-Gm-Features: AZwV_Qj-X4TaF0JJQyYNzQrgxVfwUTtBwkl-o5lUaawfB6Td6cOzQDiCt2wzft8
Message-ID: <CAHHeUGV3W+LbGEnGB_Fbehy1PB2P2y1MkAnu6OTUKTeZC0yxJQ@mail.gmail.com>
Subject: Re: [PATCH rdma-next 01/10] RDMA/umem: Add reference counting to ib_umem
To: Jiri Pirko <jiri@resnulli.us>
Cc: Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org, jgg@ziepe.ca, 
	mrgolin@amazon.com, gal.pressman@linux.dev, sleybo@amazon.com, 
	parav@nvidia.com, mbloch@nvidia.com, yanjun.zhu@linux.dev, 
	wangliang74@huawei.com, marco.crivellari@suse.com, roman.gushchin@linux.dev, 
	phaddad@nvidia.com, lirongqing@baidu.com, ynachum@amazon.com, 
	huangjunxian6@hisilicon.com, kalesh-anakkur.purayil@broadcom.com, 
	ohartoov@nvidia.com, michaelgur@nvidia.com, shayd@nvidia.com, 
	edwards@nvidia.com, andrew.gospodarek@broadcom.com, 
	selvin.xavier@broadcom.com, 
	Sriharsha Basavapatna <sriharsha.basavapatna@broadcom.com>
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000006e89230649ebb653"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-16456-lists,linux-rdma=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	TO_DN_SOME(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sriharsha.basavapatna@broadcom.com,linux-rdma@vger.kernel.org];
	DKIM_TRACE(0.00)[broadcom.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-rdma];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,resnulli.us:email]
X-Rspamd-Queue-Id: 4EE05DA230
X-Rspamd-Action: no action

--0000000000006e89230649ebb653
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 6:50=E2=80=AFPM Jiri Pirko <jiri@resnulli.us> wrote:
>
> Tue, Feb 03, 2026 at 02:03:35PM +0100, leon@kernel.org wrote:
> >On Tue, Feb 03, 2026 at 01:46:21PM +0100, Jiri Pirko wrote:
> >> Tue, Feb 03, 2026 at 01:26:18PM +0100, leon@kernel.org wrote:
> >> >On Tue, Feb 03, 2026 at 11:11:39AM +0100, Jiri Pirko wrote:
> >> >> Tue, Feb 03, 2026 at 11:03:27AM +0100, leon@kernel.org wrote:
> >> >> >On Tue, Feb 03, 2026 at 09:49:53AM +0100, Jiri Pirko wrote:
> >> >> >> From: Jiri Pirko <jiri@nvidia.com>
> >> >> >>
> >> >> >> Introduce reference counting for ib_umem objects to simplify mem=
ory
> >> >> >> lifecycle management when umem buffers are shared between the co=
re
> >> >> >> layer and device drivers.
> >> >
> >> >The lifecycle should be confined either to the core or to the driver,
> >> >but it should not mix responsibilities across both.
> >>
> >> Okay, I can re-phrase. The point is, the last holding reference actual=
ly
> >> does the release.
> >>
> >>
> >> >
> >> >> >>
> >> >> >> When the core RDMA layer allocates an ib_umem and passes it to a=
 driver
> >> >> >> (e.g., for CQ or QP creation with external buffers), both layers=
 need
> >> >> >> to manage the umem lifecycle. Without reference counting, this r=
equires
> >> >> >> complex conditional release logic to avoid double-frees on error=
 paths
> >> >> >> and leaks on success paths.
> >> >> >
> >> >> >This sentence doesn't align with the proposed change.
> >> >>
> >> >> Hmm, I'm not sure why you think it does not align. It exactly descr=
ibes
> >> >> the code I had it originally without this path in place :)
> >> >
> >> >There is no complex conditional release logic which this reference
> >> >counting solves. That counting allows delayed, semi-random release,
> >> >nothing more.
> >>
> >> Again. Without the refcount, you have to make sure the umem is consume=
d
> >> by the op. Actually, check the existing create_cq_umem. On the error
> >> path, the umem is released by the caller. On success path the ownershi=
p
> >> is transferred to the calle.
> >
> >We need to fix it. Exactly right now, I'm working to make sure that umem
> >is managed by ib_core and drivers don't call to ib_umem_get() at all.
>
> Should I wait and rebase?
>
>
> >
> >> Consider various error paths in the calle
> >> some of which are shared with destroy_cq op, some umems are not actual=
ly
> >> used etc, it's a nightmare. I had the code written down like this
> >> originally, that's why I actually know.
> >>
> >> Perhaps I'm missing your point. Is is just about the patch descriptio =
or
> >> about the code itself?
> >
> >Description and the code. UMEM needs to be created by ib_core and
> >ib_core should destroy them.

I'm seeing a kernel crash when perftest is stopped, I'm still
debugging it, but I'm wondering if it is related to this change. I see
this inline comment in the uverbs handler:

        /* Driver took a reference, release ours */
        ib_umem_release(rq_dbr_umem);
        ib_umem_release(sq_dbr_umem);
        ib_umem_release(rq_umem);
        ib_umem_release(sq_umem);

What does it mean by "Driver took a reference"? If the driver returns
success from create_qp_umem(), the umem it is still using gets
released above? Is there something that the driver should call to hold
a reference? It is not obvious from the create_qp_umem() dev op.


> >
> >>
> >>
> >> >
> >> >>
> >> >> >
> >> >> >>
> >> >> >> With reference counting:
> >> >> >> - Core allocates umem with refcount=3D1
> >> >> >> - Driver calls ib_umem_get_ref() to take a reference
> >> >> >> - Both layers can unconditionally call ib_umem_release()
> >> >> >> - The umem is freed only when the last reference is dropped
> >> >> >>
> >> >> >> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> >> >> >> Change-Id: Ifb1765ea3b14dab3329294633ea5df063c74420d
> >> >> >
> >> >> >Please remove the Change-Ids and write the commit message yourself=
,
> >> >> >without relying on AI. The current message provides no meaningful
> >> >>
> >> >> I'm new in RDMA. Not sure what you mean by meaningful information :=
)
> >> >
> >> >This part of commit message is clearly generated by Cursor:
> >> >With reference counting:
> >> >- Core allocates umem with refcount=3D1
> >> >- Driver calls ib_umem_get_ref() to take a reference
> >> >- Both layers can unconditionally call ib_umem_release()
> >> >- The umem is freed only when the last reference is dropped
> >> >
> >> >The above paragraphs have clear AI pattern as they don't explain why,
> >> >but only how.
> >>
> >> Why is explained above, isn't it?
> >> If you don't want the "how part", I can remove it, no problem.
> >
> >Commit message should provide an additional information, which is not
> >available in the code itself. Description like "Core allocates umem with
> >refcount=3D1" has zero value.
>
> :), sure
>
>
> >
> >Thanks
> >
> >>
> >>
> >> >
> >> >I'm seeing the SAME commit messages in many internals and externals
> >> >patches.
> >> >
> >> >Even my AI review is agreed with me :)
> >> >...
> >> >"AI-authorship-score": "medium"
> >> >...
> >> >
> >> >> I'm always trying to provide it.
> >> >>
> >> >> >information, particularly the auto=E2=80=91generated summary at th=
e end.
> >> >>
> >> >> Doh, the changeIDs :) Sorry about that.
> >> >>
> >> >>
> >> >> >
> >> >> >Thanks
> >> >> >
> >> >> >> ---
> >> >> >>  drivers/infiniband/core/umem.c        | 5 +++++
> >> >> >>  drivers/infiniband/core/umem_dmabuf.c | 1 +
> >> >> >>  drivers/infiniband/core/umem_odp.c    | 3 +++
> >> >> >>  include/rdma/ib_umem.h                | 9 +++++++++
> >> >> >>  4 files changed, 18 insertions(+)
> >> >> >>
> >> >> >> diff --git a/drivers/infiniband/core/umem.c b/drivers/infiniband=
/core/umem.c
> >> >> >> index 8137031c2a65..09ce694d66ea 100644
> >> >> >> --- a/drivers/infiniband/core/umem.c
> >> >> >> +++ b/drivers/infiniband/core/umem.c
> >> >> >> @@ -192,6 +192,7 @@ struct ib_umem *ib_umem_get(struct ib_device=
 *device, unsigned long addr,
> >> >> >>        umem =3D kzalloc(sizeof(*umem), GFP_KERNEL);
> >> >> >>        if (!umem)
> >> >> >>                return ERR_PTR(-ENOMEM);
> >> >> >> +      refcount_set(&umem->refcount, 1);
> >> >> >>        umem->ibdev      =3D device;
> >> >> >>        umem->length     =3D size;
> >> >> >>        umem->address    =3D addr;
> >> >> >> @@ -280,11 +281,15 @@ EXPORT_SYMBOL(ib_umem_get);
> >> >> >>  /**
> >> >> >>   * ib_umem_release - release memory pinned with ib_umem_get
> >> >> >>   * @umem: umem struct to release
> >> >> >> + *
> >> >> >> + * Decrement the reference count and free the umem when it reac=
hes zero.
> >> >> >>   */
> >> >> >>  void ib_umem_release(struct ib_umem *umem)
> >> >> >>  {
> >> >> >>        if (!umem)
> >> >> >>                return;
> >> >> >> +      if (!refcount_dec_and_test(&umem->refcount))
> >> >> >> +              return;
> >> >> >>        if (umem->is_dmabuf)
> >> >> >>                return ib_umem_dmabuf_release(to_ib_umem_dmabuf(u=
mem));
> >> >> >>        if (umem->is_odp)
> >> >> >> diff --git a/drivers/infiniband/core/umem_dmabuf.c b/drivers/inf=
iniband/core/umem_dmabuf.c
> >> >> >> index 939da49b0dcc..5c5286092fca 100644
> >> >> >> --- a/drivers/infiniband/core/umem_dmabuf.c
> >> >> >> +++ b/drivers/infiniband/core/umem_dmabuf.c
> >> >> >> @@ -143,6 +143,7 @@ ib_umem_dmabuf_get_with_dma_device(struct ib=
_device *device,
> >> >> >>        }
> >> >> >>
> >> >> >>        umem =3D &umem_dmabuf->umem;
> >> >> >> +      refcount_set(&umem->refcount, 1);
> >> >> >>        umem->ibdev =3D device;
> >> >> >>        umem->length =3D size;
> >> >> >>        umem->address =3D offset;
> >> >> >> diff --git a/drivers/infiniband/core/umem_odp.c b/drivers/infini=
band/core/umem_odp.c
> >> >> >> index 572a91a62a7b..7be30fda57e3 100644
> >> >> >> --- a/drivers/infiniband/core/umem_odp.c
> >> >> >> +++ b/drivers/infiniband/core/umem_odp.c
> >> >> >> @@ -144,6 +144,7 @@ struct ib_umem_odp *ib_umem_odp_alloc_implic=
it(struct ib_device *device,
> >> >> >>        if (!umem_odp)
> >> >> >>                return ERR_PTR(-ENOMEM);
> >> >> >>        umem =3D &umem_odp->umem;
> >> >> >> +      refcount_set(&umem->refcount, 1);
> >> >> >>        umem->ibdev =3D device;
> >> >> >>        umem->writable =3D ib_access_writable(access);
> >> >> >>        umem->owning_mm =3D current->mm;
> >> >> >> @@ -185,6 +186,7 @@ ib_umem_odp_alloc_child(struct ib_umem_odp *=
root, unsigned long addr,
> >> >> >>        if (!odp_data)
> >> >> >>                return ERR_PTR(-ENOMEM);
> >> >> >>        umem =3D &odp_data->umem;
> >> >> >> +      refcount_set(&umem->refcount, 1);
> >> >> >>        umem->ibdev =3D root->umem.ibdev;
> >> >> >>        umem->length     =3D size;
> >> >> >>        umem->address    =3D addr;
> >> >> >> @@ -245,6 +247,7 @@ struct ib_umem_odp *ib_umem_odp_get(struct i=
b_device *device,
> >> >> >>        if (!umem_odp)
> >> >> >>                return ERR_PTR(-ENOMEM);
> >> >> >>
> >> >> >> +      refcount_set(&umem_odp->umem.refcount, 1);
> >> >> >>        umem_odp->umem.ibdev =3D device;
> >> >> >>        umem_odp->umem.length =3D size;
> >> >> >>        umem_odp->umem.address =3D addr;
> >> >> >> diff --git a/include/rdma/ib_umem.h b/include/rdma/ib_umem.h
> >> >> >> index 0a8e092c0ea8..44264f78eab3 100644
> >> >> >> --- a/include/rdma/ib_umem.h
> >> >> >> +++ b/include/rdma/ib_umem.h
> >> >> >> @@ -10,6 +10,7 @@
> >> >> >>  #include <linux/list.h>
> >> >> >>  #include <linux/scatterlist.h>
> >> >> >>  #include <linux/workqueue.h>
> >> >> >> +#include <linux/refcount.h>
> >> >> >>  #include <rdma/ib_verbs.h>
> >> >> >>
> >> >> >>  struct ib_ucontext;
> >> >> >> @@ -19,6 +20,7 @@ struct dma_buf_attach_ops;
> >> >> >>  struct ib_umem {
> >> >> >>        struct ib_device       *ibdev;
> >> >> >>        struct mm_struct       *owning_mm;
> >> >> >> +      refcount_t              refcount;
> >> >> >>        u64 iova;
> >> >> >>        size_t                  length;
> >> >> >>        unsigned long           address;
> >> >> >> @@ -110,6 +112,12 @@ static inline bool __rdma_umem_block_iter_n=
ext(struct ib_block_iter *biter)
> >> >> >>
> >> >> >>  struct ib_umem *ib_umem_get(struct ib_device *device, unsigned =
long addr,
> >> >> >>                            size_t size, int access);
> >> >> >> +
> >> >> >> +static inline void ib_umem_get_ref(struct ib_umem *umem)
> >> >> >> +{
> >> >> >> +      refcount_inc(&umem->refcount);
> >> >> >> +}
> >> >> >> +
> >> >> >>  void ib_umem_release(struct ib_umem *umem);
> >> >> >>  int ib_umem_copy_from(void *dst, struct ib_umem *umem, size_t o=
ffset,
> >> >> >>                      size_t length);
> >> >> >> @@ -188,6 +196,7 @@ static inline struct ib_umem *ib_umem_get(st=
ruct ib_device *device,
> >> >> >>  {
> >> >> >>        return ERR_PTR(-EOPNOTSUPP);
> >> >> >>  }
> >> >> >> +static inline void ib_umem_get_ref(struct ib_umem *umem) { }
> >> >> >>  static inline void ib_umem_release(struct ib_umem *umem) { }
> >> >> >>  static inline int ib_umem_copy_from(void *dst, struct ib_umem *=
umem, size_t offset,
> >> >> >>                                    size_t length) {
> >> >> >> --
> >> >> >> 2.51.1
> >> >> >>
> >> >> >>

--0000000000006e89230649ebb653
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
tJVewHuOmXgWQxNWV7Oiszu1d9xAcqyj65s1PrEIIaHnxEM3eTK+teecLEy8QymZjjDTrCHg4x36
2AczdlQAIiq5TSAucGja5VP8g1zTnfL/RAxEZvLS471GABptArolXY2hMVHdVEYcTduZlu8aHARc
phXveOB5/l3bPqpMVf2aFalv4ab733Aw6cPuQkbtwpMFifp9Y3s/0HGBfADomK4OeDTDJfuvCp8g
a907E48SjOJBGkh6c6B3ace2XH+CyB7+WBsoK6hsrV5twAXSe7frgP4lN/4Cm2isQl3D7vXM3PBQ
ddI2aZzmewTfbgZptt4KCUhZh+t7FGB6ZKppQ++Rx0zsGN1s71MtjJnhXvJyPs9UyL1n7KQPTEX/
07kwIwdMjxC/hpbZmVq0mVccpMy7FYlTuiwFD+TEnhmxGDTVTJ267fcfrySVBHioA7vugeXaX3yL
SqGQdCWnsz5LyCxWvcfI7zjiXJLwefechLp0LWEBIH5+0fJPB1lfiy1DUutGDJTh9WZHeXfVVFsf
rSQ3y0VaTqBESMjYsJnFFYQJ9tZJScBluOYacW6gqPGC6EU+bNYC1wpngwVayaQQMIIGszCCBJug
AwIBAgIMPiCpKhlPGjqoQ++SMA0GCSqGSIb3DQEBCwUAMFIxCzAJBgNVBAYTAkJFMRkwFwYDVQQK
ExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBDQSAy
MDIzMB4XDTI1MDYyMDEzNTQwNVoXDTI3MDYyMTEzNTQwNVowgfIxCzAJBgNVBAYTAlVTMRMwEQYD
VQQIEwpDYWxpZm9ybmlhMREwDwYDVQQHEwhTYW4gSm9zZTEZMBcGA1UEYRMQTlRSVVMrREUtNjYx
MDExNzEUMBIGA1UEBBMLQmFzYXZhcGF0bmExEjAQBgNVBCoTCVNyaWhhcnNoYTEWMBQGA1UEChMN
QlJPQURDT00gSU5DLjErMCkGA1UEAwwic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJyb2FkY29tLmNv
bTExMC8GCSqGSIb3DQEJARYic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJyb2FkY29tLmNvbTCCASIw
DQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAKS3kXt4zVFK0i5F3y88WV5rV0rr2S3nOVTaCGMB
o6Se8pIb2HJcdpQ4rMiJuIRSyG2XDWv6OB+66eM/6cD2oklFcdzpC4/eYOQFWJ/XM8+ms6HT7P5e
uE7sY6CeUzLzHNjcRwVgZRWlELghY7DIW9fbMzRNDFsbxuIN/7eSofavP1q7PF3+DqhHZpmrVkDu
vcEBTRZSn8NWZ0Xhy4a+Y3KN2W55hh6pWQWO0lt2TtpyaqYp95egJGqDUPtqydci+qrBzXbL05Q0
gcK0NfqGJwLsEVqxHwzz/jRrzKBYKQEK4Bpau91oxVGLmxy1nQDiyI1121xyvsJBDctKH245XZkC
AwEAAaOCAeYwggHiMA4GA1UdDwEB/wQEAwIFoDAMBgNVHRMBAf8EAjAAMIGTBggrBgEFBQcBAQSB
hjCBgzBGBggrBgEFBQcwAoY6aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3Nn
Y2NyNnNtaW1lY2EyMDIzLmNydDA5BggrBgEFBQcwAYYtaHR0cDovL29jc3AuZ2xvYmFsc2lnbi5j
b20vZ3NnY2NyNnNtaW1lY2EyMDIzMGUGA1UdIAReMFwwCQYHZ4EMAQUDAzALBgkrBgEEAaAyASgw
QgYKKwYBBAGgMgoDAjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9y
ZXBvc2l0b3J5LzBBBgNVHR8EOjA4MDagNKAyhjBodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dz
Z2NjcjZzbWltZWNhMjAyMy5jcmwwLQYDVR0RBCYwJIEic3JpaGFyc2hhLmJhc2F2YXBhdG5hQGJy
b2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSMEGDAWgBQAKTaeXHq6D68tUC3b
oCOFGLCgkjAdBgNVHQ4EFgQU9Dwqof/Zp1ZdK6zi7XdRGdBWQt0wDQYJKoZIhvcNAQELBQADggIB
AKzx/6ognUMhNv+rh7iQOeHdGA7WMDixk+zrD7TZL6O5DPqXfFqaTLpswyruTymA3AVxZkMJyF6D
zOAsRfU23BjVlgC95zl1glr7DorZW7B/CQDwbLHlkFy92Oa3E+gBzwdiDMjnq6tOW5p83zoVqiV4
qm4OwC9JILEkslV4uZVXHPm5cZoOQURTECE2BN34Qhg5qD3EKYqOTeMVRed1qQiIPqQv1b4xjPVS
qBwNPl7/4TJGiZGnRB7FsNnNUQRJONnEFifM3KGqjbqA4F8BhLXCYjqtBxxCGA5506StNfsjT8UU
28E6lcuJXC4hQXau+xXQ5GWqS4ecWwm22FAVy/i8FJVfXPTJnZeixmqaadbIU3fOJs5+XfyNkU2T
mlCafSr7KgV570M6tITSyminW/7rc8hdznGYypCNa+45JYJTaK4x1+Ejptaxc7TCS12B1zQNCxa7
AHX5PZra3SpDb7g1p1i1Ax0JVJTkThiCSNDbiauVn7xIJpf+H8HC6O2ddGmtKUxe6NseFnSGJsi6
7lO/cU+TpduV7w3weUy+nHhp+GsbClfvAGhFAs/GkyONExCwwIEVlFp9Mj5JLAgB+ceMbojBIoaO
d5rOzdIII5FDwKAAqyjHuniYLrP0xIH4L5kWOAy+LudP4PSze7uAxTiCiSJg5AaNBTa5NuwTnSX6
MYICVzCCAlMCAQEwYjBSMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEo
MCYGA1UEAxMfR2xvYmFsU2lnbiBHQ0MgUjYgU01JTUUgQ0EgMjAyMwIMPiCpKhlPGjqoQ++SMA0G
CWCGSAFlAwQCAQUAoIHHMC8GCSqGSIb3DQEJBDEiBCDdfmk5ooA+kiP2m2mkpawJXAXJNpYj5U1O
WUE8bs0eNTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJBTEPFw0yNjAyMDMx
MzQ5NDdaMFwGCSqGSIb3DQEJDzFPME0wCwYJYIZIAWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgB
ZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEF
AASCAQCF13sKGf8bqkcRhQyf0CMQUPoaOQj0PihSAZrXXpjWOfG2+s8pgQWIzbN5O6KPeNiFQtLb
E7enmTY6U5liWR4jvXQRsWgMntCwLpssDQXYK2e++4ngwV6OnofuyRTqqwJX1ZPeXSdLkUDchVzq
t3Jx0LljN9t4QnspK21hEXCNfQPwoeu7iv7GitysTzIxqHF3PFTEjm5SyxfBHlgUQOL+pVTRqMnz
racd+z3z7zs7M4n+bdsDWX7Ku4EJwfDcf/hMV+9mXh8bEezRnhMlJfCNASC1m1BIcRDPfSsUCOYh
XTcrQ2JRY48iUdtbGEORfY5gRtKPYSV8miAQaNqBJ90D
--0000000000006e89230649ebb653--

