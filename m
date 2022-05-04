Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFD55519444
	for <lists+linux-rdma@lfdr.de>; Wed,  4 May 2022 03:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245356AbiEDBy3 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 May 2022 21:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245518AbiEDBw0 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 May 2022 21:52:26 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB4E44132A
        for <linux-rdma@vger.kernel.org>; Tue,  3 May 2022 18:47:39 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d15so171452plh.2
        for <linux-rdma@vger.kernel.org>; Tue, 03 May 2022 18:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=szeqM9M0yrMyJS9vcuYR4tTzvEASeBs+sh1JgS4qPAo=;
        b=SNMym2HDPaFxMLeJFcK68nelvSK8kE0Z3iij6ppE4Nnk5PkLPyihqCWqJWEyxTK+Ad
         Wlo0fMMZpa7cEJ44ZnUWiYYlbNhSmn3I+2rzPJ3v+90je6UlKRw4Aqz10rVm1pygvoeV
         KVh5PeFOgavCCRafhGFy8OhJb2FMOsRW4OkVk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=szeqM9M0yrMyJS9vcuYR4tTzvEASeBs+sh1JgS4qPAo=;
        b=PB0nPIyoe3cnt4G2aRBR548K9HB0Ko03EDnrtTTvewtmCDMihY8RDUSX0p6Y8CLjTO
         X+leKBkNyS0ljl2t0szhPBAYKqHvVjKFAD7K+zABJDirDgpXRr2+4b35M7MU0HGn7kdL
         tU3LYp1YT/hhZ9eJBVpA6uJmenE4ud1H3UWJuaT3M6IQjH/zHHTpZ7F8dbWuhVI8CA0q
         qCFNLYJ+QH0XQwCV8U6baHwYonDkOIQHIqtpSLNXoCgpga48hMQzeOrPGS//PJcGSN0e
         t6DlhKhn1L3juNfwYil9YhM2FHR9Jct0orADJPG4j/C9rUIoxrHYqDOYHIPFCzLflpu1
         viPA==
X-Gm-Message-State: AOAM530EAOiwCa31mNUmjpQdGv6NiWyiC2OIzd7Qvji4s7Mb51mocEm8
        DtQbdXdDwkvx261RqPUA83ptfw==
X-Google-Smtp-Source: ABdhPJyLljkiQcnpMeBAkbABtu5tfsx1RQAtFvxNI6eRYUdVP5PUSieP/fvUB77typ12OdIz4mCUCg==
X-Received: by 2002:a17:902:c952:b0:15e:9e3d:8e16 with SMTP id i18-20020a170902c95200b0015e9e3d8e16mr14572083pla.51.1651628858230;
        Tue, 03 May 2022 18:47:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k21-20020aa792d5000000b0050dc7628159sm6928738pfa.51.2022.05.03.18.47.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 May 2022 18:47:37 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A . R . Silva" <gustavoars@kernel.org>
Cc:     Kees Cook <keescook@chromium.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        SHA-cyfmac-dev-list@infineon.com, netdev@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        alsa-devel@alsa-project.org, Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Gabbasov <andrew_gabbasov@mentor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Gross <agross@kernel.org>,
        Andy Lavr <andy.lavr@gmail.com>,
        Baowen Zheng <baowen.zheng@corigine.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Bradley Grove <linuxdrivers@attotech.com>,
        Christian Brauner <brauner@kernel.org>,
        =?UTF-8?q?Christian=20G=C3=B6ttsche?= <cgzones@googlemail.com>,
        Christian Lamparter <chunkeey@googlemail.com>,
        Chris Zankel <chris@zankel.net>,
        Cong Wang <cong.wang@bytedance.com>,
        Daniel Axtens <dja@axtens.net>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Dan Williams <dan.j.williams@intel.com>,
        David Gow <davidgow@google.com>,
        David Howells <dhowells@redhat.com>,
        Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
        devicetree@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        Eli Cohen <elic@nvidia.com>,
        Eric Paris <eparis@parisplace.org>,
        Eugeniu Rosca <erosca@de.adit-jv.com>,
        Felipe Balbi <balbi@kernel.org>,
        Francis Laniel <laniel_francis@privacyrequired.com>,
        Frank Rowand <frowand.list@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Hulk Robot <hulkci@huawei.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        James Morris <jmorris@namei.org>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        John Keeping <john@metanate.com>,
        Juergen Gross <jgross@suse.com>,
        Keith Packard <keithp@keithp.com>, keyrings@vger.kernel.org,
        kunit-dev@googlegroups.com,
        Kuniyuki Iwashima <kuniyu@amazon.co.jp>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Lee Jones <lee.jones@linaro.org>,
        Leon Romanovsky <leon@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux1394-devel@lists.sourceforge.net,
        linux-afs@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-hardening@vger.kernel.org, linux-hyperv@vger.kernel.org,
        linux-integrity@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        llvm@lists.linux.dev, Loic Poulain <loic.poulain@linaro.org>,
        Louis Peens <louis.peens@corigine.com>,
        Luca Coelho <luciano.coelho@intel.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Mark Brown <broonie@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Paul Moore <paul@paul-moore.com>,
        Rich Felker <dalias@aerifal.cx>,
        Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>, selinux@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Simon Horman <simon.horman@corigine.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Stefan Richter <stefanr@s5r6.in-berlin.de>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Stephen Smalley <stephen.smalley.work@gmail.com>,
        Tadeusz Struk <tadeusz.struk@linaro.org>,
        Takashi Iwai <tiwai@suse.com>, Tom Rix <trix@redhat.com>,
        Udipto Goswami <quic_ugoswami@quicinc.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        wcn36xx@lists.infradead.org, Wei Liu <wei.liu@kernel.org>,
        xen-devel@lists.xenproject.org,
        Xiu Jianfeng <xiujianfeng@huawei.com>,
        Yang Yingliang <yangyingliang@huawei.com>
Subject: [PATCH 05/32] brcmfmac: Use mem_to_flex_dup() with struct brcmf_fweh_queue_item
Date:   Tue,  3 May 2022 18:44:14 -0700
Message-Id: <20220504014440.3697851-6-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220504014440.3697851-1-keescook@chromium.org>
References: <20220504014440.3697851-1-keescook@chromium.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2425; h=from:subject; bh=LUlPP0dMftItb3yi/Nge8ZTfomS6k0b5Ud+psHgt9Uk=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBicdqBCnVywLtiCXwEUYb08oAOpk1h97YdS8IXrTwN m34sdVuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYnHagQAKCRCJcvTf3G3AJokcD/ 944yjyiL4MM2Llyg3BhqwjaPE/1VNwGW9grsHKNIASpW8lInBdW90HjydT+vZ0wCt1VpknFi2upnQI XFtVoH0BT1G9pp4WHMjMMAaSqS3XB0bqdYs4DVvPzTKh5kGr5jX6k9+GTSve/itnWwnYDdM80IlUNt S0IhtkWMACqLlgyqGlt11fTu2Zpj0mRgIVFYh1FPaQRGj+skxj5+tzJqnIxOvBBPtzMq5leG8tzvRp gGF1ADH/0BhWsidIuY5CltVSgionGZ0at33CGy6Yb686fc3WZxfkwUqwKd4kWy0/RHSdYt4O0S9KnY r3h5ztCJtoyE+LsOyQfAjweyIO2LhMxNdieb0lZcJ/4W95rILXttIhcQ8iyf4yAsY69UgQuHPKDcAf nBH2PYzGNfEsEHmEr7bOtF2WG7xXUZXn6gi1luh2tpxiaDAkWSbwC0/Hg4An1+r4RDKB8TaO47Qgsp PG9QvJ1Ej3BAp6hSui4/P+qsMcNSEBBM0dZS2Ro11mi+jDDxK5En0Xgd/el0xn+qwqq+NFNlC0jKcW /QhhJ9GSxPsZzAT51pgi/Q//ZlDNoXI6Xmoho22SXd2se2PmaeWQDnuPK8bWnerpItxcrS1KP5jR9H przw+F/g76E2CP74njdcHJE58D4/zsqYKWbbLWi2QfpgIWTEZ+hV+/A44Ihw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

As part of the work to perform bounds checking on all memcpy() uses,
replace the open-coded a deserialization of bytes out of memory into a
trailing flexible array by using a flex_array.h helper to perform the
allocation, bounds checking, and copying.

Cc: Arend van Spriel <aspriel@gmail.com>
Cc: Franky Lin <franky.lin@broadcom.com>
Cc: Hante Meuleman <hante.meuleman@broadcom.com>
Cc: Kalle Valo <kvalo@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: linux-wireless@vger.kernel.org
Cc: brcm80211-dev-list.pdl@broadcom.com
Cc: SHA-cyfmac-dev-list@infineon.com
Cc: netdev@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 .../net/wireless/broadcom/brcm80211/brcmfmac/fweh.c   | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
index bc3f4e4edcdf..bea798ca6466 100644
--- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
+++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
@@ -32,8 +32,8 @@ struct brcmf_fweh_queue_item {
 	u8 ifidx;
 	u8 ifaddr[ETH_ALEN];
 	struct brcmf_event_msg_be emsg;
-	u32 datalen;
-	u8 data[];
+	DECLARE_FLEX_ARRAY_ELEMENTS_COUNT(u32, datalen);
+	DECLARE_FLEX_ARRAY_ELEMENTS(u8, data);
 };
 
 /*
@@ -395,7 +395,7 @@ void brcmf_fweh_process_event(struct brcmf_pub *drvr,
 {
 	enum brcmf_fweh_event_code code;
 	struct brcmf_fweh_info *fweh = &drvr->fweh;
-	struct brcmf_fweh_queue_item *event;
+	struct brcmf_fweh_queue_item *event = NULL;
 	void *data;
 	u32 datalen;
 
@@ -414,8 +414,7 @@ void brcmf_fweh_process_event(struct brcmf_pub *drvr,
 	    datalen + sizeof(*event_packet) > packet_len)
 		return;
 
-	event = kzalloc(sizeof(*event) + datalen, gfp);
-	if (!event)
+	if (mem_to_flex_dup(&event, data, datalen, gfp))
 		return;
 
 	event->code = code;
@@ -423,8 +422,6 @@ void brcmf_fweh_process_event(struct brcmf_pub *drvr,
 
 	/* use memcpy to get aligned event message */
 	memcpy(&event->emsg, &event_packet->msg, sizeof(event->emsg));
-	memcpy(event->data, data, datalen);
-	event->datalen = datalen;
 	memcpy(event->ifaddr, event_packet->eth.h_dest, ETH_ALEN);
 
 	brcmf_fweh_queue_event(fweh, event);
-- 
2.32.0

