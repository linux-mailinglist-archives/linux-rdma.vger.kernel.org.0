Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13327633FBD
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Nov 2022 16:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbiKVPC1 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Nov 2022 10:02:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbiKVPCD (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Nov 2022 10:02:03 -0500
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F2718B0B;
        Tue, 22 Nov 2022 07:00:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
        Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
        :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
        Resent-Cc:Resent-Message-ID; bh=+NFpLSd8ScOHEVd4DHTztoyZ+UkB3J/9rUIzBb7GyY0=;
        t=1669129239; x=1670338839; b=M4XN9XK1W5a0FSbzeMQpJI7YfGc4KLqku3aIDcoSTviF46U
        Tjum65SNwV7blxEtkrq70yR1nrlawSGN8RPBRrlaCaQfmfCeBussv6sdgC16zA/JACLvFXglfLGti
        tyZWeutUSS1t1EL/sf6k/2f4VDe8Kz8dJ8mXHOXIChu2IoRZdI6mxvfX7y6tK8d55o0udNvYnB48l
        2jkzWhsLco2GCmx3+5zD1AIW1CD/OoEJYSFfeNj5THvmhRamLOzBGllFz3UNBwfvpUOIuD+tQ210r
        +ftThAwGnUT1rqyknPaGbddy03l14pUZgPE9iJw1rvEzPUXEM/k62gNvbQwIgisQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.96)
        (envelope-from <johannes@sipsolutions.net>)
        id 1oxUlH-006Ngc-2Z;
        Tue, 22 Nov 2022 16:00:35 +0100
Message-ID: <021efb6c9295402cf05406bb319c441c0b0229b3.camel@sipsolutions.net>
Subject: Re: Build regressions/improvements in v6.1-rc6
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Alex Deucher <alexdeucher@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-um@lists.infradead.org,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org
Date:   Tue, 22 Nov 2022 16:00:34 +0100
In-Reply-To: <CADnq5_PvouSKugXxJXqkVeZf+kbP8+hhUKFgVALSO=MOW3jzvA@mail.gmail.com>
References: <CAHk-=wjKJyzfJmOzBdEOqCFRc8Fh-rdGM4tvMXfW0WXbbHwV0w@mail.gmail.com>
         <20221122105054.4062213-1-geert@linux-m68k.org>
         <alpine.DEB.2.22.394.2211221154280.284524@ramsan.of.borg>
         <CADnq5_PvouSKugXxJXqkVeZf+kbP8+hhUKFgVALSO=MOW3jzvA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 (3.44.4-2.fc36) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Tue, 2022-11-22 at 08:55 -0500, Alex Deucher wrote:
> >=20
> >    + /kisskb/src/arch/um/include/asm/processor-generic.h: error: called=
 object is not a function or function pointer:  =3D> 94:18
> >    + /kisskb/src/drivers/gpu/drm/amd/amdgpu/../amdkfd/kfd_topology.c: e=
rror: control reaches end of non-void function [-Werror=3Dreturn-type]:  =
=3D> 1934:1
> >=20
> > um-x86_64/um-all{mod,yes}config (in kfd_cpumask_to_apic_id())
>=20
> Presumably cpu_data is not defined on um-x86_64?  Does it even make
> sense to build drivers on um-x86_64?

Drivers in general yes ;-)

This driver, probably not.

But the issue is that a lot of drivers "depends on X86_64" or such,
where only "X86" is the arch symbol. You could add "X86 && X86_64" to
really build on x86 64-bit only.

I didn't check this driver, but this has mostly popped up since UM got
PCI support some time ago (which I added.)

johannes


