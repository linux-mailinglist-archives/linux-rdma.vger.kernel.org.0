Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2715A746A35
	for <lists+linux-rdma@lfdr.de>; Tue,  4 Jul 2023 09:00:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230338AbjGDHAD (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 4 Jul 2023 03:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjGDG76 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 4 Jul 2023 02:59:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89C8FB
        for <linux-rdma@vger.kernel.org>; Mon,  3 Jul 2023 23:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688453951;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0IleIxpNn+PMHgV028qieppTFJnd95N2jqDTi5xYgrM=;
        b=A1Ov6fXZa9DLfzmf8fWJFQmvD6lrPcZE/1dqsgoknYtp8W7s4/lVcprRkVBDxxbojzzv9g
        tECaT4bjAhkRJEoI4ruoRPiarQQB8GQj3S8hAXXoOA/dhGUPT4x6NUzn+/mSH5biPEjTh6
        /MUVUtII7JcBzG1INZUmwEESdM9pgmI=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-BbkqtP_ENkaagTL-6LrJgA-1; Tue, 04 Jul 2023 02:59:09 -0400
X-MC-Unique: BbkqtP_ENkaagTL-6LrJgA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-7672918d8a4so154903285a.0
        for <linux-rdma@vger.kernel.org>; Mon, 03 Jul 2023 23:59:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688453949; x=1691045949;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0IleIxpNn+PMHgV028qieppTFJnd95N2jqDTi5xYgrM=;
        b=R1DuXkP6j7u/nW6IgjyCkFO2XFylX0TsFYWj9oyOYtWc2HRsCVTd0uWJ8Q4ZH+Vmf4
         5yz2w2KBLTSOJO7MevAKv9X6tdFCrQupNe1mqEuPCK6AuuxoKJHxt0FFgwZhqpAwNrTG
         xDr3PjKUFYuLLMd8lUR93tqsLJE9sfrvrGz9XrPw+sTvyIAG1361w+GrawXIjJBfAEa6
         C8zysmLRwLVxByDSgQgG7yenJlRyeZiI2VhGr9P3iCu85MUxPZEH0Xg3+yVfl5USLjQ4
         j8BS+XBPrGd7riwFNUQMfDNT0vov8oWgW+hvdrySLRL+TBxM7Jl7TFu5RvYgGSlQyxW2
         qFOg==
X-Gm-Message-State: ABy/qLazYZgPY12MxvZhb2Se2KceS5A4kFCnUFTbF9eGs8FbLrKiiav8
        Qd2PG+X/hAEOF4kLGA7kHx26BoM+VjFfsJfTyfjDyBZ/FTeYTlf6tClyrx3/hZ1ZYfxiUMJszWH
        E6pkXD4DV2CDHKKaFszhGPQ==
X-Received: by 2002:a05:620a:1aa4:b0:765:58ac:9458 with SMTP id bl36-20020a05620a1aa400b0076558ac9458mr14719921qkb.7.1688453949243;
        Mon, 03 Jul 2023 23:59:09 -0700 (PDT)
X-Google-Smtp-Source: APBJJlEzlcNLkagvW9k+kp5MGjOwZWN9zlneIyGcDYmRHiEtbwaDGwG+DfHs99YP8WgUKWv70lEQoQ==
X-Received: by 2002:a05:620a:1aa4:b0:765:58ac:9458 with SMTP id bl36-20020a05620a1aa400b0076558ac9458mr14719893qkb.7.1688453948908;
        Mon, 03 Jul 2023 23:59:08 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-247-156.dyn.eolo.it. [146.241.247.156])
        by smtp.gmail.com with ESMTPSA id pe34-20020a05620a852200b007623c96430csm9632974qkn.111.2023.07.03.23.59.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jul 2023 23:59:08 -0700 (PDT)
Message-ID: <8b0696a63d3f9cdcd4d9a8d933826e9ea1cb126b.camel@redhat.com>
Subject: Re: [EXTERNAL] Re: [PATCH V4 net] net: mana: Fix MANA VF unload
 when host is unresponsive
From:   Paolo Abeni <pabeni@redhat.com>
To:     Souradeep Chakrabarti <schakrabarti@microsoft.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        souradeep chakrabarti <schakrabarti@linux.microsoft.com>
Cc:     KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        Dexuan Cui <decui@microsoft.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "edumazet@google.com" <edumazet@google.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        Long Li <longli@microsoft.com>,
        Ajay Sharma <sharmaajay@microsoft.com>,
        "leon@kernel.org" <leon@kernel.org>,
        "cai.huoqing@linux.dev" <cai.huoqing@linux.dev>,
        "ssengar@linux.microsoft.com" <ssengar@linux.microsoft.com>,
        "vkuznets@redhat.com" <vkuznets@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Date:   Tue, 04 Jul 2023 08:59:03 +0200
In-Reply-To: <PUZP153MB07880E6D692FD5D13C508694CC29A@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
References: <1688374171-10534-1-git-send-email-schakrabarti@linux.microsoft.com>
         <83ef6401-8736-8416-c898-2fbbb786726e@intel.com>
         <PUZP153MB07880E6D692FD5D13C508694CC29A@PUZP153MB0788.APCP153.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On Mon, 2023-07-03 at 19:55 +0000, Souradeep Chakrabarti wrote:
> > -----Original Message-----
> > From: Alexander Lobakin <aleksander.lobakin@intel.com>
> > Sent: Monday, July 3, 2023 10:18 PM
> > To: souradeep chakrabarti <schakrabarti@linux.microsoft.com>
> > Cc: KY Srinivasan <kys@microsoft.com>; Haiyang Zhang
> > <haiyangz@microsoft.com>; wei.liu@kernel.org; Dexuan Cui
> > <decui@microsoft.com>; davem@davemloft.net; edumazet@google.com;
> > kuba@kernel.org; pabeni@redhat.com; Long Li <longli@microsoft.com>; Aja=
y
> > Sharma <sharmaajay@microsoft.com>; leon@kernel.org;
> > cai.huoqing@linux.dev; ssengar@linux.microsoft.com; vkuznets@redhat.com=
;
> > tglx@linutronix.de; linux-hyperv@vger.kernel.org; netdev@vger.kernel.or=
g;
> > linux-kernel@vger.kernel.org; linux-rdma@vger.kernel.org;
> > stable@vger.kernel.org; Souradeep Chakrabarti <schakrabarti@microsoft.c=
om>
> > Subject: [EXTERNAL] Re: [PATCH V4 net] net: mana: Fix MANA VF unload wh=
en
> > host is unresponsive
> >=20
> > From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> > Date: Mon,  3 Jul 2023 01:49:31 -0700
> >=20
> > > From: Souradeep Chakrabarti <schakrabarti@linux.microsoft.com>
> >=20
> > Please sync your Git name and Git mail account settings, so that your o=
wn
> > patches won't have "From:" when sending. From what I see, you need to
> > correct first letters of name and surname to capital in the Git email s=
ettings
> > block.
> Thank you for pointing, I will fix it.
> >=20
> > >=20
> > > When unloading the MANA driver, mana_dealloc_queues() waits for the
> > > MANA hardware to complete any inflight packets and set the pending
> > > send count to zero. But if the hardware has failed,
> > > mana_dealloc_queues() could wait forever.
> > >=20
> > > Fix this by adding a timeout to the wait. Set the timeout to 120
> > > seconds, which is a somewhat arbitrary value that is more than long
> > > enough for functional hardware to complete any sends.
> > >=20
> > > Signed-off-by: Souradeep Chakrabarti
> > > <schakrabarti@linux.microsoft.com>
> >=20
> > Where's "Fixes:" tagging the blamed commit?
> This is present from the day zero of the mana driver code.
> It has not been introduced in the code by any commit.
>=20

Then the fixes tag should be:

Fixes: ca9c54d2d6a5 ("net: mana: Add a driver for Microsoft Azure Network A=
dapter (MANA)")

Cheers,

Paolo

