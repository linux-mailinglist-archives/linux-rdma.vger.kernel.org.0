Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F12175182D
	for <lists+linux-rdma@lfdr.de>; Thu, 13 Jul 2023 07:34:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233766AbjGMFev (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 13 Jul 2023 01:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232495AbjGMFeu (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 13 Jul 2023 01:34:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 819EA1993
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jul 2023 22:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689226453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=SmfB+i5ITyD8VcQT6H0n4jQbBtZaHz3osNrT9kioxiQ=;
        b=NqdSY9QUqllBHTpPVoWI3R2S5L8Go75LijLMG8At1Ttr4M1bqFIPZnW+Bv+4dndT4DFynH
        cWLhSvcbJMqJbOrX0EVRk+ws1JDHFKQNMEQ8hIbhldrsSQ78WKlLW6r8vCS7m35sky4sXH
        8e43CBxa6HpJDr/6x7QvyyjZjB2ID6s=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-157-zDhPHlpuPTKBbM4CrOpF6Q-1; Thu, 13 Jul 2023 01:34:11 -0400
X-MC-Unique: zDhPHlpuPTKBbM4CrOpF6Q-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-315926005c9so267946f8f.0
        for <linux-rdma@vger.kernel.org>; Wed, 12 Jul 2023 22:34:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689226451; x=1691818451;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SmfB+i5ITyD8VcQT6H0n4jQbBtZaHz3osNrT9kioxiQ=;
        b=JA/bwxD1xhhNm406Ow2IIe1RqEF3B0sxBHFTuYGOHZ0mI7fRZ2K0kB7Zx8tn3bTXFn
         yctemylMx8KaGof8n+Nrg+wpxHeDgbY3XBi0iN6esH382Rk2HsDXlJe3M6KZ3w++2jKg
         CU0aJPc35bjoCKFfIgVgOZKU7tquYvVy/+QzXrNi5wBFf0KFxjJQ7v5B2h8k/rAI5ytJ
         CjozobbPcB4n0NLfsQXRUMjl/85aD88yEUekyvReM3EXlZ8h0h61OHvWtLSrvaqnl4qq
         SrtI6JJ9REkEetIam6XGjE6EnP0bZ/0k0O5fsWESzR39+Ly9jGjMEzejwXx+m/M6rIXV
         91Mg==
X-Gm-Message-State: ABy/qLbDKt2B/ocMnOWGK7DBmBOQvtOj3XRufAnjIrlZ+6FbxW+Rnvbk
        UHppJTfpI2QuiCXFbSjeWtc4s0jjc7jcYZssmt1ArmGhy1yli78K+lL5r+R14V9tRKhLvAGiTDw
        F4QqVFdk7fjnh1SsdlqRSnDb/JL7MM0T5evkZ+g==
X-Received: by 2002:a05:6000:92:b0:314:35c2:c4aa with SMTP id m18-20020a056000009200b0031435c2c4aamr466991wrx.8.1689226450812;
        Wed, 12 Jul 2023 22:34:10 -0700 (PDT)
X-Google-Smtp-Source: APBJJlGOJnBSbefoa2jYNguz42ZsRuZYJIodpjHhXJuzkLT9wNSNcgOUvRAkGCM4TmbRTEw+GkFxz47vkJZ0YZi65gI=
X-Received: by 2002:a05:6000:92:b0:314:35c2:c4aa with SMTP id
 m18-20020a056000009200b0031435c2c4aamr466974wrx.8.1689226450472; Wed, 12 Jul
 2023 22:34:10 -0700 (PDT)
MIME-Version: 1.0
From:   Vitaly Grinberg <vgrinber@redhat.com>
Date:   Thu, 13 Jul 2023 08:33:59 +0300
Message-ID: <CACLnSDiMD+BH_BBHQUAhSvfqe6jhnm4MOB2N_hog4VMhvdTYVg@mail.gmail.com>
Subject: Re: [RFC PATCH v9 00/10] Create common DPLL configuration API
To:     Jiri Pirko <jiri@resnulli.us>
Cc:     David Airlie <airlied@redhat.com>, andy.ren@getcruise.com,
        anthony.l.nguyen@intel.com,
        "Kubalewski, Arkadiusz" <arkadiusz.kubalewski@intel.com>,
        arnd@arndb.de, axboe@kernel.dk,
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

Hi,
I'd like to clarify about the DPLL phase offset requirement. We can
live without it during the initial submission. The addition of phase
offset can be an increment to patch v10.
Thanks,
Vitaly

