Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8BCF554E6E
	for <lists+linux-rdma@lfdr.de>; Wed, 22 Jun 2022 17:04:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358543AbiFVPEM (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 22 Jun 2022 11:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358925AbiFVPED (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 22 Jun 2022 11:04:03 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A6693EB87
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jun 2022 08:03:53 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id s185so10600227pgs.3
        for <linux-rdma@vger.kernel.org>; Wed, 22 Jun 2022 08:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=vhZEVnaGNBjosB86GDUW8b2wHjB/+QU31bPXl36TqFE=;
        b=Jt/qXO7TwQJF3EWuk5p4azKGOCxq/Rzk3KoLqC6Pwff+0tHhs8als9639cidnzFde4
         ry7ero38QELHA22RBkZWtE0xNRPiiPEWIvKtPd0fZpNhUDrKHRyETW5WgRrbPPmi6/vT
         vJpxoQNLrGfsMgIfV+PXszjD1nMaBRUe0Gxx0eYZw7YGtSc5pfRkGeshne5cjr5BaKxu
         3INPcNuWqxw7/0puGY6UuhzUSAv6SoxD7Bz3CVHuDQWru55+lIHO02gOv78FJXnTYNjB
         rbtWgbiyhkE21LXWR11Bk6fRJOPFFcU92J8XbdNavb7vvb9W0t8MjYRzeI2ufnWOCsiS
         AGLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=vhZEVnaGNBjosB86GDUW8b2wHjB/+QU31bPXl36TqFE=;
        b=brGz9fulVu76Un5lvRNQyUADizawdm87ZMo+xO2mStILIrUGX5d/68nGEEnLnxA5no
         Vz8o+al0l9wTuW0nMv/wqfdgqdIaY2SaiHbUkcOXBWELHfN5qkIZcQO7Ndm3TglzFeKV
         IDLQw5FqUIPfwjM8+VGjkEcLDe3YeW+TLRSdgDbcQJ9aUJId1ZGNGAGKLJTV0jtM/0Oa
         jr4i2HrTSWyHrAqcQx30cNdzFQptyiXqRCQpn7qZjRQUvkcYXgB/8uDIo8by4V1G3/ad
         3KzMVcP1uG8CfldiurGQaHAlb+bKcyO3DE/5Bc/maqXKg5sPtgEX0VfOkkogyHTeHd6T
         xRAA==
X-Gm-Message-State: AJIora8G7MVcvsy4zvfCeF7OgxQrN4d5ILMnIMULR6o4NnxmRUdbNgQ0
        5GJ4Nx3w2we+qGr9SS7WpTp26Ciw7WAqau5L4r0=
X-Google-Smtp-Source: AGRyM1uVFGSnpr+dTCH2B3yi91+xpZWxlNuq532hGAWMLDkFZu1Qrq3wwA6KogrJ63y1ppaQwcWp21NviyeWeo5Xswg=
X-Received: by 2002:a63:af1c:0:b0:40c:f9fb:deca with SMTP id
 w28-20020a63af1c000000b0040cf9fbdecamr3305128pge.479.1655910232628; Wed, 22
 Jun 2022 08:03:52 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a17:903:2308:b0:16a:1b3f:f74b with HTTP; Wed, 22 Jun 2022
 08:03:51 -0700 (PDT)
Reply-To: sales0212@asonmedsystemsinc.com
From:   Prasad Ronni <lerwickfinance7@gmail.com>
Date:   Wed, 22 Jun 2022 16:03:51 +0100
Message-ID: <CAFkto5szY9scoLwccBhUx92cgUVnT2cx2c=WmxiOTkm7N_y9gg@mail.gmail.com>
Subject: Service Needed.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

-- 
Hi,

Are you currently open to work as our executive company representative
on contractual basis working remotely? If yes, we will be happy to
share more details. Looking forward to your response.

Regards,
