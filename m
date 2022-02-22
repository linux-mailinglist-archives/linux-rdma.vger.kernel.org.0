Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D99C4BF88F
	for <lists+linux-rdma@lfdr.de>; Tue, 22 Feb 2022 13:57:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232116AbiBVM57 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 22 Feb 2022 07:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232209AbiBVM5x (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 22 Feb 2022 07:57:53 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C954CAC904
        for <linux-rdma@vger.kernel.org>; Tue, 22 Feb 2022 04:57:18 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id x193so14377614oix.0
        for <linux-rdma@vger.kernel.org>; Tue, 22 Feb 2022 04:57:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=khFlKyL1ha/xVPi4Z/tm+G2VlHL6EyOop4wEzn3U5zk=;
        b=px/ihf28mZVz/NwYn0jmTRkFIbXtcoNtstp0yDnKCKFtZGCqfTCWBb4F1jC837s5cH
         +uFEyP5SaVaahv0ba9PWm0gKglnyTAyYi5Yf3FTXAKMT4BXl1FJrB/691/oGOk3vGInG
         8lP7Cf/18Qmyh0aYRtml1Th881uavMN9hM4tHa+Rs1h8Et/aTg9B0b/APmDQ4SDET3dS
         dtOurDfDaaRW5ACEzAaJ594HQUg7OAePLsoVziGIIbPLEs785Tly0dtHI6aRK7uSg/SY
         a/7x/6Sr0+CH0GnQpfvlxBZqw/YaYzsj1/ywDEeMxUq3LsYI793TBXZKn0o4saoCJggM
         cU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=khFlKyL1ha/xVPi4Z/tm+G2VlHL6EyOop4wEzn3U5zk=;
        b=ho59zMg74aLCXawvnYjQtg+l0xAZIn8Z30SFl+g7Y76fijuAYhIQnyyVHtZR5/ywRH
         YUz2YjuSaf1sDaGbgmG08ubpDtPwKQGL7DaqGq3t5rBWPTVpqiJ7q7nvi6LswVcBNX+b
         5E8L7dNf731w0YW9NBu7j188EP/2k6Hi11pUQ2+EXbmV4ZJXddD2lT/6ymcywfZcXqvI
         +jfd2AUcC8CN/gV12EclnSniErrzXoUceTdg9LtOmvXm4eu0Sc6pV6+GHoaMKHI3y7W2
         G4lEPtFZhw2fMxwM4AkhaSyY8HW4oAPdZbyPQZZeRIwcrNpTiauAuL4ADO5dZKxv1+n/
         WYhg==
X-Gm-Message-State: AOAM533+EGXEEt9B0S4gl3sz19clA1toLq139+1ZVzdrsRRoUYb4AYto
        dE/E//4a367OgnVA5ACZUGzmunX56Lc4Wv9BH04=
X-Google-Smtp-Source: ABdhPJx0sS+YaAI8GBj6vfXVBNr9BoZMECeN+OBKn+JQZ1xTeVQ75aLAxzfpZ90kz+EqzXZoaduTXJuw9bMSeD327Xo=
X-Received: by 2002:a05:6808:30c:b0:2d4:655b:c8c4 with SMTP id
 i12-20020a056808030c00b002d4655bc8c4mr1910641oie.90.1645534638032; Tue, 22
 Feb 2022 04:57:18 -0800 (PST)
MIME-Version: 1.0
Sender: jibrilmrmustafa@gmail.com
Received: by 2002:a05:6840:bdad:b0:bba:1b26:7635 with HTTP; Tue, 22 Feb 2022
 04:57:17 -0800 (PST)
From:   AISHA GADDAFI <madamisha00@gmail.com>
Date:   Tue, 22 Feb 2022 13:57:17 +0100
X-Google-Sender-Auth: H5LsItH4jQRUU41ejmOo2_vT0wg
Message-ID: <CA+wbLbEduJehBGi8_s632VvQVO_Hv6jyhszc-o-AEo9fT1LgMw@mail.gmail.com>
Subject: I want to invest in your country
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.7 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,LOTS_OF_MONEY,
        MILLION_HUNDRED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY,URG_BIZ autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

--=20
I want to invest in your country
Greetings Sir/Madam.
May i use this medium to open a mutual communication with you, and
seeking your acceptance towards investing in your country under your
management as my partner, My name is Aisha Gaddafi , i am a Widow and
single Mother with three Children, the only biological Daughter of
late Libyan President (Late Colonel Muammar Gaddafi) and presently i
am under political asylum protection by the  Government of this
nation.
I have funds worth =E2=80=9CTwenty Seven Million Five Hundred Thousand Unit=
ed
State Dollars=E2=80=9D -$27.500.000.00 US Dollars which i want to entrust o=
n
you for investment project in your country. If you are willing to
handle this project on my behalf, kindly reply urgent to enable me
provide you more details to start the transfer process.
I shall appreciate your urgent response through my email address
below: gaddafi.mrsaisha@bk.ru
Thanks
Yours Truly Aisha
