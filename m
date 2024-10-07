Return-Path: <linux-rdma+bounces-5262-lists+linux-rdma=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D33C992773
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 10:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3FB2281D24
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Oct 2024 08:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2733154454;
	Mon,  7 Oct 2024 08:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="jIF6Fq6b"
X-Original-To: linux-rdma@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A926C2628C
	for <linux-rdma@vger.kernel.org>; Mon,  7 Oct 2024 08:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728290880; cv=none; b=Lsz+uxBpxjARRo5/P7oP4VLGntIGslsiCNRRtyQCoAvTuKBz6RxWu3NU1R5U+pgKWwBVawZRibtxQh+mWERmP1wJR3e988mVWqNWx+POppNutGWk1xtKOFdfTO01D0d13bd/X3kwa+ksXBti1WFeXswXm/5GU2uXDvp7XT4JaIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728290880; c=relaxed/simple;
	bh=3nmWKsdY9MAo0sb1y6+SddDaObdvZ26hbRw7dHER2cs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CdALhltw/+ltu87hsHaCl1Aqo+m2DwTVioAlui6XNNSkKywYx8kSR4qinwRpQoC+MfA8JWluJigLtWmuRzwfS8L/kr9t2k2oO55NvpDpKV/jOMneRo4b4aiSKj7jG1yA0OWrpWnVYTDzBNeXOfis5kb/HivPmieV+ITh6tBQVyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=jIF6Fq6b; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a995ec65c35so46215566b.1
        for <linux-rdma@vger.kernel.org>; Mon, 07 Oct 2024 01:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1728290874; x=1728895674; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NzUEqLGgBpjhYFGQZ9H8BLVfnvq+rcdLqmkgHafR+4k=;
        b=jIF6Fq6bS7qbphSyfFPTgGh71sZ93Nrsh0nw6HLQwQ54XlryzA/WRAcl2oMqKeZCcT
         602efVxGh1fsUillqEY09laFStqr+2fbd4fngcpFXtt2xwL59VIE7qMyixscZ8xW++NB
         e6EXR8/lmu8E0UAG7tPhKHtp+7o4CbFN0y+yRakXuLV9NC0zuXa32BNqiYghxQQ1RKoo
         N5JqzKSHyAr3yBQMEmHmheKiR22+5RTsR09p2Y71KfpgmY4WGd992gnRb/9BVP3+MJ9s
         WjeScoBuMhtW13BBDnUswC5RXO/pS2D+CHTlwlye/V8dpXR0uw7jkWsj9Cvf10jfP+F4
         pfZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728290874; x=1728895674;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NzUEqLGgBpjhYFGQZ9H8BLVfnvq+rcdLqmkgHafR+4k=;
        b=DjLEXa8RIGqJUbq5KO75HrOvqLxIRAKiEt+kbRLVxuRppYh1G5qFnhL/KInjm41LOB
         eEPPgre4JEDAyV4AnbYnF3cMGKlCIOFFIOXGS7gYSWpEJtmmLFiUBMZF8D+JslG/2CH1
         R2xkoXnKhplZuHT2Qi3Lf/W7mgkZOIx1X9jqI7gl+Qdkb0jCqN9SDfozZ3Kki4hOjxTm
         BA+neJrIZJ2njmtEMa2Fs68ez3bfAINEhogAAtH6p/IclXZm+7vITcTl82qU+RdgVaGE
         iLnZP0/1fmBuuXqPEdTHm1WyW+8kkOPXIGMy+xPvcbwqcHP4HdDvTc4WBh4h8Ej5i7Um
         65zA==
X-Forwarded-Encrypted: i=1; AJvYcCUSp8+bVQe4s36CqsH61Bxex81mcSHT8MEmSR5U7Dq6om1B8uWr6TpqHEkSD/ISAVlP0RBG9GeTD6ys@vger.kernel.org
X-Gm-Message-State: AOJu0YwWxbAliccth98NmIQADLyvnzoJYiawQVVc5SBQLYP+u2uiXvI/
	1W2zrCx/7ruI7uqH7y6GEfKL/hGIpaIfyOirE82ef1pRwVRSILqzsH2kgYnJvwVQvmHeBST07IT
	Iq+5xv9ftGRqGkQVZsDceQOL11dWsQBNPq5nYDw==
X-Google-Smtp-Source: AGHT+IERaQnCPkAK/FIfZ14/veEXDzO8cK7gQpVnqkVORGG78Cam24um86yXZInGL4nQR0ZJmzJ6/VchHf492NRNDl0=
X-Received: by 2002:a17:907:f144:b0:a99:4045:c88a with SMTP id
 a640c23a62f3a-a994045caf4mr627124266b.0.1728290873844; Mon, 07 Oct 2024
 01:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-rdma@vger.kernel.org
List-Id: <linux-rdma.vger.kernel.org>
List-Subscribe: <mailto:linux-rdma+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-rdma+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240827165643-mutt-send-email-mst@kernel.org>
 <027c4f24-f515-4fdb-8770-6bf2433e0f43@akamai.com> <84c74f1a95a648b18c9d41b8c5ef2f60@huawei.com>
 <ZvQnbzV9SlXKlarV@x1n> <DM6PR12MB431364C7A2D94609B4AAF9A8BD6B2@DM6PR12MB4313.namprd12.prod.outlook.com>
 <0730fa9b-49cd-46e4-9264-afabe2486154@akamai.com> <Zvrq7nSbiLfPQoIY@x1n>
 <DM6PR12MB4313D6BA256740DE1ACA29E9BD762@DM6PR12MB4313.namprd12.prod.outlook.com>
 <ZvsAV0MugV85HuZf@x1n> <c24fa344-0add-477d-8ed3-bf2e91550e0b@akamai.com>
 <Zv8P8uQmSowF8sGl@x1n> <6211c525-0b9b-4eba-ac3c-2ac796c8ec83@akamai.com>
In-Reply-To: <6211c525-0b9b-4eba-ac3c-2ac796c8ec83@akamai.com>
From: Yu Zhang <yu.zhang@ionos.com>
Date: Mon, 7 Oct 2024 10:47:43 +0200
Message-ID: <CAHEcVy7_WveokcN+3J2Qqxg8oJ1BT8sNoU2qUHeU8oZWwVyS6g@mail.gmail.com>
Subject: Re: [PATCH 0/6] refactor RDMA live migration based on rsocket API
To: Michael Galaxy <mgalaxy@akamai.com>
Cc: Sean Hefty <shefty@nvidia.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, 
	"elmar.gerdes@ionos.com" <elmar.gerdes@ionos.com>, zhengchuan <zhengchuan@huawei.com>, 
	"berrange@redhat.com" <berrange@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, 
	"lizhijian@fujitsu.com" <lizhijian@fujitsu.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, 
	Xiexiangyou <xiexiangyou@huawei.com>, 
	"linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "lixiao (H)" <lixiao91@huawei.com>, 
	"jinpu.wang@ionos.com" <jinpu.wang@ionos.com>, Wangjialin <wangjialin23@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sure, as we talked at the KVM Forum, a possible approach is to set up
two VMs on a physical host, configure the SoftRoCE, and run the
migration test in two nested VMs to ensure that the migration data
traffic goes through the emulated RDMA hardware. I will continue with
this and let you know.


On Fri, Oct 4, 2024 at 4:06=E2=80=AFPM Michael Galaxy <mgalaxy@akamai.com> =
wrote:
>
>
> On 10/3/24 16:43, Peter Xu wrote:
> > !-------------------------------------------------------------------|
> >    This Message Is From an External Sender
> >    This message came from outside your organization.
> > |-------------------------------------------------------------------!
> >
> > On Thu, Oct 03, 2024 at 04:26:27PM -0500, Michael Galaxy wrote:
> >> What about the testing solution that I mentioned?
> >>
> >> Does that satisfy your concerns? Or is there still a gap here that nee=
ds to
> >> be met?
> > I think such testing framework would be helpful, especially if we can k=
ick
> > it off in CI when preparing pull requests, then we can make sure nothin=
g
> > will break RDMA easily.
> >
> > Meanwhile, we still need people committed to this and actively maintain=
 it,
> > who knows the rdma code well.
> >
> > Thanks,
> >
>
> OK, so comments from Yu Zhang and Gonglei? Can we work up a CI test
> along these lines that would ensure that future RDMA breakages are
> detected more easily?
>
> What do you think?
>
> - Michael
>

