Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13E174221F
	for <lists+linux-rdma@lfdr.de>; Thu, 29 Jun 2023 10:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbjF2I1j (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 29 Jun 2023 04:27:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231848AbjF2I1b (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 29 Jun 2023 04:27:31 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CA0B2D51
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jun 2023 01:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1688027202;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2X/9hjh4GCRep3Yr5A88t6/9ZJUgY/QuDsFgqFDxHcg=;
        b=UalajFWSBy0qITeImnTR8Yh+pO5iHnOpdgx7eKPuyYugE3YwonarzuAn6iBBMJUdJpFw3g
        Ptf+ggvnF23HcYQjKgKxSbKu/kBo772JrysoXAj4KCr+ciz0sgpkJlDExITHYHfQJ1WdX3
        WWR105kFr1OzgbgINMKWJ/WD47hSuQo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-HvJ4YNhiMMuyAuJ3BmbSBQ-1; Thu, 29 Jun 2023 04:26:40 -0400
X-MC-Unique: HvJ4YNhiMMuyAuJ3BmbSBQ-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3141325af78so266116f8f.3
        for <linux-rdma@vger.kernel.org>; Thu, 29 Jun 2023 01:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688027199; x=1690619199;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2X/9hjh4GCRep3Yr5A88t6/9ZJUgY/QuDsFgqFDxHcg=;
        b=Uj7EEnbU6CAtMkaEM50yhURCF7BzVdgwGehQLZzEMAOJlMUXoVn0Z+PgYXJOov3MYH
         drDoeQK1PNcToN5Z44Rlc2+u0yPdgHeGvsazrlm9e9OLiyqTiLl8JIXSK4fxSIAGZOLz
         wQta3NksqDywO/kEYbmPylXGFO79RZqOO99e9YvQGHll4hNLrjw/rBSolaxgs4zehaJd
         E74S4ZOKqV5fOMEOgzKpHuLbrl3fLslxlhj8ngBV4s6MBv1B6g0vn8QtVNtJp8sMHf0x
         ycMEFCRMDZlEkKFNzCbLnCb+hivrcEq+47X52wW6ILVwToB4xQgNC6E0EpYLSErR9OU4
         QHAg==
X-Gm-Message-State: AC+VfDyLvIvx0lUAHB3gDGnmOgNrj0bMM6n9m8ZrYYr6hx0K+aNuUwOC
        rbGs1kEeXSUBVyu/2P+/s41Q+IK6ss0PTYFk7A0ekTy5PLgWTsKL6VbO1bdaHohtyJOKA8kkPkw
        2ZpqMH2O4CEj5tgJo2b6olcXNdKKrRKs/rpIweA==
X-Received: by 2002:a5d:4c49:0:b0:307:9702:dfc8 with SMTP id n9-20020a5d4c49000000b003079702dfc8mr32317064wrt.48.1688027199778;
        Thu, 29 Jun 2023 01:26:39 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7omIpTgTvWmp/XA4qHqIcJGGRJMHLQApXBTxOevoUf3FMPyDoPRMaq5jK0ngggDraIqFDpoXXUgwpysfyG+3w=
X-Received: by 2002:a5d:4c49:0:b0:307:9702:dfc8 with SMTP id
 n9-20020a5d4c49000000b003079702dfc8mr32317009wrt.48.1688027199420; Thu, 29
 Jun 2023 01:26:39 -0700 (PDT)
MIME-Version: 1.0
References: <CACLnSDhkUA=19905RKk=f1WBkd3jTEDcvytJCgavi90FroXb5w@mail.gmail.com>
 <ZJ0/StDYFANB1COA@nanopsycho>
In-Reply-To: <ZJ0/StDYFANB1COA@nanopsycho>
From:   Vitaly Grinberg <vgrinber@redhat.com>
Date:   Thu, 29 Jun 2023 11:26:28 +0300
Message-ID: <CACLnSDgudK155J8myg99Q+sr18sUy5nJOQsBWtgsFBPGRVhDCQ@mail.gmail.com>
Subject: Re: [RFC PATCH v8 00/10] Create common DPLL configuration API
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
        David Airlie <airlied@redhat.com>, andy.ren@getcruise.com,
        anthony.l.nguyen@intel.com, arnd@arndb.de, axboe@kernel.dk,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        claudiajkang@gmail.com, corbet@lwn.net, davem@davemloft.net,
        edumazet@google.com, geert+renesas@glider.be,
        gregkh@linuxfoundation.org, hkallweit1@gmail.com,
        idosch@nvidia.com, intel-wired-lan@lists.osuosl.org,
        jacek.lawrynowicz@linux.intel.com,
        Javier Martinez Canillas <javierm@redhat.com>,
        jesse.brandeburg@intel.com, jonathan.lemon@gmail.com,
        kuba@kernel.org, kuniyu@amazon.com, leon@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux@zary.sk, liuhangbin@gmail.com,
        lucien.xin@gmail.com, masahiroy@kernel.org,
        michal.michalik@intel.com, milena.olech@intel.com,
        Michal Schmidt <mschmidt@redhat.com>,
        Michael Tsirkin <mst@redhat.com>, netdev@vger.kernel.org,
        nicolas.dichtel@6wind.com, nipun.gupta@amd.com, ogabbay@kernel.org,
        Paolo Abeni <pabeni@redhat.com>, phil@nwl.cc,
        Petr Oros <poros@redhat.com>, razor@blackwall.org,
        ricardo.canuelo@collabora.com, richardcochran@gmail.com,
        saeedm@nvidia.com, sj@kernel.org, tzimmermann@suse.de,
        vadfed@fb.com, vadfed@meta.com, vadim.fedorenko@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jiri,
We are pushing for it to be implemented in Intel Ice driver.
Thanks,
Vitaly

On Thu, Jun 29, 2023 at 11:22=E2=80=AFAM Jiri Pirko <jiri@resnulli.us> wrot=
e:
>
> Thu, Jun 22, 2023 at 09:44:19AM CEST, vgrinber@redhat.com wrote:
> >Hi,
> >Could it be possible to add PPS DPLL phase offset to the netlink API? We
> >are relying on it in the E810-based grandmaster implementation.
>
> In which driver you need to implement this?
>
>
> >Thanks,
> >Vitaly
>

