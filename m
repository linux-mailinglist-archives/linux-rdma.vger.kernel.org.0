Return-Path: <linux-rdma+bounces-19426-lists+linux-rdma=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-rdma@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAvUGaIP5Gk7QAEAu9opvQ
	(envelope-from <linux-rdma+bounces-19426-lists+linux-rdma=lfdr.de@vger.kernel.org>)
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Apr 2026 01:11:30 +0200
X-Original-To: lists+linux-rdma@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D535242292D
	for <lists+linux-rdma@lfdr.de>; Sun, 19 Apr 2026 01:11:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A538C30254B2
	for <lists+linux-rdma@lfdr.de>; Sat, 18 Apr 2026 23:11:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F066D397E82;
	Sat, 18 Apr 2026 23:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KLZDy3RD"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A541F361662
	for <linux-rdma@vger.kernel.org>; Sat, 18 Apr 2026 23:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776553879; cv=pass; b=bdh4o+TCBopFREoatwV2D7jUeioPDl2cQQQTrIoqC+qVXd+SpcQd1nyxESxg7+ijFWFFiUsPUyogFrpid55sb9iOKwWElEEuUpZ1MuJvXHungX1kYyXpItTGEj2/rrG9wM2Yjzdg5N1+YK1+RgeoZRqjWeUTjxwRPPa1a3gi1HY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776553879; c=relaxed/simple;
	bh=lNHDlk8B5PqL85HXLmuBLf7lLyQftTt2Jedf/GoQJt0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FsEdbFLGJ/xisaJAp/yGiKOQavJdC07/y5Cb6KLXhlcyMQMZqo2U2Q+Qbth8tO3SnsyZ7qzug70Yh7K/QnIOBc/KjnsnHHRHswBh/TVvfqNABNmP3xZOjkMbEBFA/8Tl2hIRsgRFfEEup8Xh2ejrfXXa9XEohhFc1bngXhlFP0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KLZDy3RD; arc=pass smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6540fe6a8e1so838712d50.1
        for <linux-rdma@vger.kernel.org>; Sat, 18 Apr 2026 16:11:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776553878; cv=none;
        d=google.com; s=arc-20240605;
        b=g2HKspMykDYmbyGJzkLxb8fJ/ffr9K+z1qa96Y8UEho3RRCjZLy1/ijTNiE4DlRE0o
         YVp3FiZsIXW3zgg5tVjraBDKiBsgksIS+TfFT9nVcUDrGfhOs3/VYrfhGcGwo25w+YQ8
         S2PmGfPZ4KMkm/SdH20KXe9kbMcFa2vT/+6ZlZfOgVujkRIInobowTJU3ztqihfLL2lM
         LkA25DGRQh4Gda6zABlLrNaDq7LDTS375sH2dxTBCeTX/E9tkXa/P7irHmQ6ZuSG0UGf
         bcaB80uOaEDEFlNwRt3Eu3T4oRaVyyFHz8TIgVE3eS47egkHIZBlo2cR0Vq50Xw2CsOv
         +cnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vlhIOvRsNW+nGbriCGnBsuJdvmXmiApsq6Nlf2vCN/4=;
        fh=TfH99C5ZqdtLolsYs11NNR6hoT5HlMkJWqsX5BtB+jA=;
        b=PGgU/jIhypPgLp12Phvg4X/acdnXDtdTEeU9iK3ruqEM2IScYdTRMwgxzGsFAjJpo8
         RwlsCUXfJXtzPfKh0vfb2cg1TTdM4ZyV3gfGyzF7QHHdQMRKqOwTr+JjprYGXsiFJE5N
         UxPvu8HznYom0AktkEerextLSdu8h3hnq7+FixvBTsJld/XApopH/KsKQGhoAZkta5Dx
         8/+ZEIJuI/1dd2a8xMlYwANYwdVICnn3VbDOlq9+rI4Z9jq+Xuyua1cYB3yGTs30SnF+
         tbO16txd2xKkoSMHZmkZqkdw/rvIMQgDCcWtc2LHSx903tr06tHDF8cys+s5j2YMtegv
         XWXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776553878; x=1777158678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vlhIOvRsNW+nGbriCGnBsuJdvmXmiApsq6Nlf2vCN/4=;
        b=KLZDy3RDvFmcAI7Oy1AQrvCMBUSIJ4OQZSxrTSyZOtqY5qRs7NS+ENri7xkvqGUuLJ
         ytXTQX6EBMiUL+bEOdEZvSVdVSusJGxKTg3ULZOKMw4GGekKhU4CH0jd7mTq08NcGEt4
         Tb9OhhOxCsDSZcz7oCQH63GmJtj2/euOapKVvQndLcapt6oE00AhucjDlXwtAWCI7DRh
         WkVES+EKIv6Tdjq/Sw20GMeI8CsfNX8PH8xgdfVsJrst8/yG/vkLisCpNWZ701+zkyxh
         Gxyx6cDhDg6hKpC7kuY5eXkgdrYrCdEP6uig/u9Qr1TNgYLeWD4kg1lOo+80dzSdwFXR
         pYeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776553878; x=1777158678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vlhIOvRsNW+nGbriCGnBsuJdvmXmiApsq6Nlf2vCN/4=;
        b=QVS3mwsa8gYeW+/7u5M+dAEjdLXGbdgATI/1l8XZzRSwHbRCeIn4a1ZFgFgCLGz0Dk
         zxPCV24XmBAEaL/7lhap9ewe0rxQAU2ka4EgldRhSRsNKdecqRwNshyBG4yyDtCwL6jE
         3Gm+ZNxhZQpEEh65yoaJ/nKkvmSfsBPS30zSw4d9wuODBRi9/PW1VuP3MTKQRyqJhvUu
         sFsVdsnd6bTuk6blaalJiYta3U4KgQZ1pnGeFHd8zXboOih8QISUPxphOm/ogEicdiD0
         qhVsTYSDM2aNzxSkOCSIZ+pBCXMY4iyuQtYi/WJcIf0sRe/kqywOyezyc5+ax28Usow0
         psSQ==
X-Forwarded-Encrypted: i=1; AFNElJ/m+jxeYStI9YPRhzbIC7gazKR4hB5NZLMzboO2U3TS9lOo9j0yzeneDLq2tQjQ6cy9hNA5mBNTtVIs@vger.kernel.org
X-Gm-Message-State: AOJu0YxN9AGl3G4iRQTE65qgAOXfSknzZhQarj44XD+NCENnlxVi0Jyh
	emh5xxH+HuDdS8SGAapa2nETCnBhxq14pnckWdXvANUV/noJBFxpkYBveGMUcgsuL/uKc+LhlUi
	/MQ+8M328JJJlZzjGOUQQCvEJ0LNhqNk=
X-Gm-Gg: AeBDiesgOZpTFHIoytunFeJekZ5mDZtHbKvzJcvHhBQDEv4JFyzD5dnEKbObsWhXRo/
	myybdqO8Vg0z0QLsAAKKGPd4+aHKPcpORYQvy3VqnHHNkSHAytjAnvgquCKA9rF9vSAVYus8Gg6
	OgsVUPGfvpIUAsQUH5acR3HJEJjC3njhW6APjf3nIqeZeRrYqAiodyCDWoQTJh015O1Eu7O4mw9
	ic4h3dgkQGURFuymvSG+aVDfYWOoYCcnBIvNJU26rGoic87W++JlXqY4QDTBLTN00/Kqczy56vJ
	neEampG0UQ6Vs3m0IaEmuQlCkV5lA+0FIfNVmm/HMlJp4vE=
X-Received: by 2002:a05:690e:1407:b0:651:d763:b492 with SMTP id
 956f58d0204a3-65310acbac9mr7671967d50.55.1776553877727; Sat, 18 Apr 2026
 16:11:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260418162141.3610201-1-michael.bommarito@gmail.com> <06470bbf-ee39-4094-8c01-5860935af0f8@linux.dev>
In-Reply-To: <06470bbf-ee39-4094-8c01-5860935af0f8@linux.dev>
From: Michael Bommarito <michael.bommarito@gmail.com>
Date: Sat, 18 Apr 2026 19:11:06 -0400
X-Gm-Features: AQROBzBIoCEfBs_nUcHWu2hP_wsKZa70El-QNwylWiL9n228ZzWIcWvi6iXUbx8
Message-ID: <CAJJ9bXza+XAX36-Fse1aW7FM-=G11bqKqf6Ds_9sArzUbZh9-w@mail.gmail.com>
Subject: Re: [PATCH] RDMA/rxe: reject non-8-byte ATOMIC_WRITE payloads
To: Zhu Yanjun <yanjun.zhu@linux.dev>
Cc: Zhu Yanjun <zyjzyj2000@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	Leon Romanovsky <leon@kernel.org>, Xiao Yang <yangx.jy@fujitsu.com>, linux-rdma@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-19426-lists,linux-rdma=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,ziepe.ca,kernel.org,fujitsu.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelbommarito@gmail.com,linux-rdma@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-rdma];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linux.dev:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: D535242292D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, Apr 18, 2026 at 6:49=E2=80=AFPM Zhu Yanjun <yanjun.zhu@linux.dev> w=
rote:
> Thanks a lot. It would be great to have a corresponding negative test in
> tools/testing/selftests/rdma that sends malformed ATOMIC_WRITE requests
> (e.g., zero-length) and verifies that they are rejected and do not
> modify the target MR.

Good idea.  Do you want a v2 with this fix + a separate test case in
rdma or should I submit it separately?

Thanks,
Mike Bommarito

