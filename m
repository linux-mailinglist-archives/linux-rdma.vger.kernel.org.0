Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFC8C434741
	for <lists+linux-rdma@lfdr.de>; Wed, 20 Oct 2021 10:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbhJTIuT (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 20 Oct 2021 04:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbhJTIuT (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 20 Oct 2021 04:50:19 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D77C06161C
        for <linux-rdma@vger.kernel.org>; Wed, 20 Oct 2021 01:48:05 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id q189so10202417ybq.1
        for <linux-rdma@vger.kernel.org>; Wed, 20 Oct 2021 01:48:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=8hhOONSzPI4Kduxex/ETyUH+jghLAd9KAEIAnuetR5w=;
        b=epVpz70OXfhDL7IeECB2+T+QK2+IPUtxVH8BR4JW7C8poQI5z5VfS8RI82v5oHyCFs
         2Ec6DxDiJn5fQzdwf6ClLYqqWgQglyPsRnm3KGHa80kdsh8z3iVtqL/D2XKO4FXMzHbv
         zuJNrOPI1QUNodpAExMymTph5FwW47KnyxR88UE4r/6ix297Y9n3/uAQxlysjeoPI80b
         UZUIbRGuvxkoHlBdzAw4zQYc2eFwlYj8FCM4tCXvjjl7f243WnU4vnYcrjh2PxNSf3uS
         eBZdVd7YA7ixw1zWiJvsUkljWvLQq+pT/mOW7zjUoo/YXBlj8o1FjVrJAJEzYLBdpvVk
         IYeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=8hhOONSzPI4Kduxex/ETyUH+jghLAd9KAEIAnuetR5w=;
        b=Q4Z6Zl167UHkDR1YngDGZHKYheHV9uXSIFz3GbHqvl5w5YvvrfL03AWTL8wUYEJmdM
         GsNqCPFpIZIEvpPZA1KYwZGa8A+xDwkDj9MFzZL7knPosACnNuAIMPzcW0d4S3w5u9WT
         iHRoU80a9N+zPFowA9t7r9k6YR5zDMDdu3vUVXsHSASrGvkBRFOoVlYoI5b01ybO+0bd
         OKeWIzNntcUVWhL0uKAerK/zf1W4/GjtOtXnPRz7dzmOxi1FDYjmw1NySPff0yFJ8J5M
         PX1hKMlZbA1v4eL7OsbzIbWVhWp546zDzqFKMqPg37mEbjqjZVgm+UNPXe5UsRIbYVYC
         xctQ==
X-Gm-Message-State: AOAM5335Ar8BlTixc3AokD1RxGl51bqnbvjmZBCXsmamfF3thsefm8F2
        LfRAP+3TDCF78oN9w3tSvoMKb0aiv2ncj6dD8b0=
X-Google-Smtp-Source: ABdhPJy1sZQ5jqIksjI1zkAJIYBHVUb7+VlGFXR0w5eLufgvsyT0EvaJekHZs2xsHslPpvMYeb87Hv+41HdV9vcUJy8=
X-Received: by 2002:a25:1b86:: with SMTP id b128mr45295442ybb.20.1634719684790;
 Wed, 20 Oct 2021 01:48:04 -0700 (PDT)
MIME-Version: 1.0
Sender: wedenimboma74@gmail.com
Received: by 2002:a05:7110:233:b0:fa:4255:e6a1 with HTTP; Wed, 20 Oct 2021
 01:48:04 -0700 (PDT)
From:   Kayla Manthey <sgtkaylamanthey612@gmail.com>
Date:   Wed, 20 Oct 2021 08:48:04 +0000
X-Google-Sender-Auth: _6ybpeJyTiMq0xmAt84tZp3rMMw
Message-ID: <CADTv18CGz4qDM-92Zpgqv6EdhFDifTZr13pVWVQqREzue=Pt0w@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

0JfQtNGA0LDQstC10LnRgtC1LCDQv9C+0LvRg9GH0LjRhdGC0LUg0LvQuCDQtNCy0LDRgtCwINC8
0Lgg0L/RgNC10LTQuNGI0L3QuCDQuNC80LXQudC70LA/INC80L7Qu9GPINC/0YDQvtCy0LXRgNC1
0YLQtSDQuCDQvNC4DQrQvtGC0LPQvtCy0L7RgNC10YLQtS4NCg==
