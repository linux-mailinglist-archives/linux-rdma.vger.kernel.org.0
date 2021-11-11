Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1081944D2AA
	for <lists+linux-rdma@lfdr.de>; Thu, 11 Nov 2021 08:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229706AbhKKHvK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 11 Nov 2021 02:51:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbhKKHvJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 11 Nov 2021 02:51:09 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A362EC061766
        for <linux-rdma@vger.kernel.org>; Wed, 10 Nov 2021 23:48:20 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id t18so1351852edd.8
        for <linux-rdma@vger.kernel.org>; Wed, 10 Nov 2021 23:48:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google;
        h=mime-version:from:date:message-id:subject:to;
        bh=v/21umhyrxOr2VflNsFlIRcQduDyaxXokueRaWFoA54=;
        b=cI7axKzDf2Os0rEMk0pNQ02TD0x1nnZ1joDXXbGRqf89n73pN3ABUjgggxTA89cCEN
         93uSCHHcDDAs4jv8tYMKlDSxn58wDd5TIEphECENgIkLk60VrHxgyseSL1ddYDHIeKKg
         xOJ4vLYyyatlITur2z/oxh6GXKa4UV/nLuKymID1eCbcKsoHPXxz8rTKXQ6Ooh1SdDhe
         5yHPUi1M3BFV8Nrh42pztIiOOuedBXsiPqRIvQ841c/7E5nxf/GY2I9RWouZO6KdlbpJ
         NLpjzhivJ4cIswXIMd+eXZ8OFQKNWxhJSjFfP9czQnpBvKjJk1CAZRE0tSJP82+rwuzN
         LVOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=v/21umhyrxOr2VflNsFlIRcQduDyaxXokueRaWFoA54=;
        b=UeVylkKzFPCTANTkTEAQ0NrUTfNFKX50OkdI4iOpjlcx2E6KSAef/ySo1UvEyctKoI
         Qcz0a5loOWQHZGrNiWdUjofh1/WC/aBCL6oKBTLLagYA6Oz+k2MFw+nibPB6Xsbcl/IB
         9C+6MsOmWoPMZiCaBKntQMEx/ky1oJyMu+Ez9MoJPWQuhkYdt0GDBRvQ9oKROvlyNNgD
         iQ06Ynv2nvtRRGo6jCZV2PAUlad0U8pcskQJrV9eEZ6vPyLbEdU+/My/aeBNw+nKdvjF
         DdfPX2qQNHLLJQMz1tgU2UjtEdcKXRLX+ihJ+sBUd1Xr4tZaON0gO8lnpn1/ad4KhBIy
         /TfQ==
X-Gm-Message-State: AOAM531B3Zj30aqqQ/4KvhcpT3HmRHAE0FzAv24KdpjZnQFg69GLsL+U
        x7+CfyUlm/9C5bxyFdn1DKOUJfSSzR1/4oxMKdk1il8KX59U4NUh
X-Google-Smtp-Source: ABdhPJwsEc17MfCycc9fFeV2wCtTE4UTyTGsW9ywRSz/lJZIL5mNRFV3fBDjFGrNl8NsJ7myCsGi6Cm7JvPFEAwOa/o=
X-Received: by 2002:a17:907:1687:: with SMTP id hc7mr6897355ejc.232.1636616899182;
 Wed, 10 Nov 2021 23:48:19 -0800 (PST)
MIME-Version: 1.0
From:   Jinpu Wang <jinpu.wang@ionos.com>
Date:   Thu, 11 Nov 2021 08:48:08 +0100
Message-ID: <CAMGffEmC07MwNsTHQ19OwUonG4zgYsx0vj+R__9as3E5EduY8A@mail.gmail.com>
Subject: Missing infiniband network interfaces after update to 5.14/5.15
To:     RDMA mailing list <linux-rdma@vger.kernel.org>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>,
        Haris Iqbal <haris.iqbal@ionos.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi Jason, hi Leon,

We are seeing exactly the same error reported here:
https://bugzilla.redhat.com/show_bug.cgi?id=2014094

I suspect it's related to
https://lore.kernel.org/all/cover.1623427137.git.leonro@nvidia.com/

Do you have any idea, what goes wrong?

Thanks!
Jinpu Wang
