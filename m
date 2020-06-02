Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05EF61EBEC9
	for <lists+linux-rdma@lfdr.de>; Tue,  2 Jun 2020 17:11:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726073AbgFBPLh (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 2 Jun 2020 11:11:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725958AbgFBPLg (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 2 Jun 2020 11:11:36 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E12AC08C5C0
        for <linux-rdma@vger.kernel.org>; Tue,  2 Jun 2020 08:11:35 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id p18so10363541eds.7
        for <linux-rdma@vger.kernel.org>; Tue, 02 Jun 2020 08:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloud.ionos.com; s=google;
        h=message-id:subject:from:to:date:user-agent:mime-version
         :content-transfer-encoding;
        bh=FJrt6koIAiJZwOu7K5CyelG6NtCn4Ri1VhaiqEjt5nA=;
        b=RlDNbh7wf7yEdOaBnYqqF0gSw0Qy+L+63CrTsosN0SZyrDNzhG1wFePgrSXY35m0cn
         H0fT/YCJvmgXhv4WuO8mtp3DobDzGIkdtTg4Q/XITU8ie4QbDnB31EPtam5YuKxKZcwH
         HqpQGuoLcXmzgGLTZyJYOBry5Erl8Pu7gKEYeEFrSXlJtMA/mjKYF8wAffk2dYLV1vtp
         pB+h/JtQCOUjJ68uZS5IhT/qlej54WW6A5bs2+8DWZ1xnBLqpES9FiCa5+H3ZnpuFRb8
         yn1zJnh7MFzrBnhmoGeTbyqPMtES9ax+PCzIFqeHexVeNX/hUCSHIXx7Grng40BoIpZp
         JK4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:date:user-agent
         :mime-version:content-transfer-encoding;
        bh=FJrt6koIAiJZwOu7K5CyelG6NtCn4Ri1VhaiqEjt5nA=;
        b=BnM4kul0WGU33J8Qnv3i6OJ92hOqmhVpIPFpaV7w4cDe9LmoouTp3gA7FpeJ3pQeXA
         KeWNarN649+UlToLy3P6UPAEnNmwbhu6FtI66g9ZcLQwVpYvg+kSUioxIstkLMpCFtup
         RR1TTZk/U8K1JTFbWzRoGbUmfp9aH2+X9yUJmD6Zx4+IaD7GedXw2ITOkDTItAc2CKvI
         KnRYoIf9Xoabuk+NAfNvjqpcIQI38ls0vP3DqAymJhFS0oDrI7dDMGJhfPAe+avfp7MD
         BwXzkMYZ1qslIRN25BXZfJ5QPcWLbr/L0bKTsPSDY5xAb+fNl00iRBHDR139x1ZR9h9q
         o/uw==
X-Gm-Message-State: AOAM531KBrxRTy3MwN2TS1UgY09hDermNblvrONGDPtFZhRvN3c7ea6R
        78F30YvNggvBflYKv3H6wEo10C1g1xmyKQ==
X-Google-Smtp-Source: ABdhPJwkw1FzLQ2far/z9cBc/XQ1N8lDRcSKKcEdbE7KJwYTbXp8QzXoqdR+HmzrOsQkMP+LR+gJcw==
X-Received: by 2002:a50:ee08:: with SMTP id g8mr2104693eds.267.1591110693640;
        Tue, 02 Jun 2020 08:11:33 -0700 (PDT)
Received: from fiftytwodotfive.bdrung.de (ip5b401b14.dynamic.kabel-deutschland.de. [91.64.27.20])
        by smtp.gmail.com with ESMTPSA id s18sm1736067edi.45.2020.06.02.08.11.31
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2020 08:11:31 -0700 (PDT)
Message-ID: <6c58097c2310a57a987959660a8612467d8bd96c.camel@cloud.ionos.com>
Subject: Race condition between / wrong load order of ib_umad and ib_ipoib
From:   Benjamin Drung <benjamin.drung@cloud.ionos.com>
To:     linux-rdma@vger.kernel.org
Date:   Tue, 02 Jun 2020 17:11:31 +0200
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.2-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,

after a kernel upgrade to version 4.19 (in-house built with Mellanox
OFED drivers), some of our systems fail to bring up their IPoIB devices
on boot. Different HCAs are affected (e.g. MT4099 and MT26428). We are
using rdma-core on Debian and have IPoIB devices (like `ib0.dddd`)
configured in `/etc/network/interfaces`. Big cluster seem to be more
affected than smaller ones. In case of the failure, we see this kernel
message:

```
ib0.dddd: P_Key 0xdddd is not found
```

Pinging other hosts will fail then with:

```
ping: sendmsg: Network is unreachable
```

Upgrading to rdma-core 29.0 did not change anything. Excluding all
InfiniBand kernel modules from the initrd reduced the likelihood to run
into this issue, but did not fix it.

We found one report on the Internet describing a similar issue, which
claims that the solution is to change/fix them module load order: 
https://community.brightcomputing.com/question/5d6614ba08e8e81e885f18ef

We use the default `/etc/rdma/modules/infiniband.conf` shipped in the
Debian package:

```
# These modules are loaded by the system if any InfiniBand device is installed
# InfiniBand over IP netdevice
ib_ipoib

# Access to fabric management SMPs and GMPs from userspace.
ib_umad

# SCSI Remote Protocol target support
# ib_srpt

# ib_ucm provides the obsolete /dev/infiniband/ucm0
# ib_ucm
```

Due to this configuration, `ib_ipoib` is loaded before `ib_umad`. After
changing the order in this configuration file to load `ib_umad` before
`ib_ipoib`, the servers come up correctly.

-- 
Benjamin Drung

DevOps Engineer and Debian & Ubuntu Developer
Platform Integration (IONOS Cloud)

1&1 IONOS SE | Greifswalder Str. 207 | 10405 Berlin | Germany
E-mail: benjamin.drung@cloud.ionos.com | Web: www.ionos.de

Hauptsitz Montabaur, Amtsgericht Montabaur, HRB 24498

Vorstand: Dr. Christian Böing, Hüseyin Dogan, Dr. Martin Endreß, Hans-
Henning Kettler, Arthur Mai, Matthias Steinberg, Achim Weiß
Aufsichtsratsvorsitzender: Markus Kadelke


Member of United Internet

Diese E-Mail kann vertrauliche und/oder gesetzlich geschützte
Informationen enthalten. Wenn Sie nicht der bestimmungsgemäße Adressat
sind oder diese E-Mail irrtümlich erhalten haben, unterrichten Sie
bitte den Absender und vernichten Sie diese E-Mail. Anderen als dem
bestimmungsgemäßen Adressaten ist untersagt, diese E-Mail zu speichern,
weiterzuleiten oder ihren Inhalt auf welche Weise auch immer zu
verwenden.

This e-mail may contain confidential and/or privileged information. If
you are not the intended recipient of this e-mail, you are hereby
notified that saving, distribution or use of the content of this e-mail 
in any way is prohibited. If you have received this e-mail in error,
please notify the sender and delete the e-mail.

