Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 658F8417E6
	for <lists+linux-rdma@lfdr.de>; Wed, 12 Jun 2019 00:06:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407860AbfFKWG6 (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 11 Jun 2019 18:06:58 -0400
Received: from mail-wr1-f42.google.com ([209.85.221.42]:46957 "EHLO
        mail-wr1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405700AbfFKWG6 (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 11 Jun 2019 18:06:58 -0400
Received: by mail-wr1-f42.google.com with SMTP id n4so14637872wrw.13
        for <linux-rdma@vger.kernel.org>; Tue, 11 Jun 2019 15:06:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=wzwMoSZCZ2rv98TS0vwYYbWzhGa5CgsUnl8GufbZ7oE=;
        b=KZ0G7c5r59kqlJAPT4OxGfjJokkYM4CyBXIO3Q7dQsI3wZJZC5diIw1cfM9wmI7eE9
         RdauGfie2Vxfah/YwHI24KfYAuK241QQ7d5MvM3fm4wajtMT9mlTfesSMIhDPb/Ecr5h
         2ApKgXwtRoMnrp7SWR25hnLnqAmX/L1tM1WGl2qoZZobp0VLwbiZu3sVbT8XJYgnt/Pl
         7MoYFHCPNiytX9zLVBc37Ez4vLed9fPAwP9JGbI1nC9LJ0Llhx3dKrdy4D0IITw0diXk
         4R+n3GC5MnNXSo1/Qt5gsnVOmzimFuhQeb7LaDMW+3H87yK2ynKXqsNcWxzcwpGeliro
         kzHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=wzwMoSZCZ2rv98TS0vwYYbWzhGa5CgsUnl8GufbZ7oE=;
        b=lkFzjDIszpSjbSC/dli0u4hHRKqkpzkie4W1fklZRfvvawCK35IP8aaSclFYpycGkb
         Al8P/LMBZv+icFMexSiCpQpgD534FteUZ47OzRgpHmueKGQW5ftY56Vg0M7Ef97Z7+Cn
         fOwF0NOY1/1Mwqs+kRIFKCUDFTbN+ZJh9DUTgiJ+QoAHt3BXicH0yPGU8r75bPN0AU7q
         Ztf61P8D5R2WeQonbEfJRpY6a9nOFfdBu5nxNacKkIBtPOq0d0MQ4LE4dLi5U6zmWfXg
         83Hn+fE1IDifD1ua9gz//kbmt8vk5fhMEYJGoU/rxF1LhuRsKdNIcSW0h6MOUhQdVJ9H
         yxMQ==
X-Gm-Message-State: APjAAAX1TI7F7hsKqLJ6ZcPO2vzAuaDfmny8VtRr251T0H8a4iO+zEcI
        asbL3jWLFbWEh6sIcRKnjccX3a+8pe8=
X-Google-Smtp-Source: APXvYqw2sr8EF8/fHj2cVK6XbMYI5/b3qTSyJ06uu6uoAuxTTE2pRsy/P+d+vL0tNMErGEhLAE0fFg==
X-Received: by 2002:a5d:4bce:: with SMTP id l14mr41174wrt.79.1560290816861;
        Tue, 11 Jun 2019 15:06:56 -0700 (PDT)
Received: from [10.128.129.210] ([141.226.120.58])
        by smtp.gmail.com with ESMTPSA id q9sm5355902wmq.9.2019.06.11.15.06.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Jun 2019 15:06:55 -0700 (PDT)
From:   Vladimir Sokolovsky <vlad@dev.mellanox.co.il>
Subject: [ANNOUNCE] OFED 4.17-1-rc2 release is available
To:     "ewg@lists.openfabrics.org" <ewg@lists.openfabrics.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Message-ID: <ca5463ac-150d-6313-9df2-db2fd60e7d54@dev.mellanox.co.il>
Date:   Wed, 12 Jun 2019 01:06:26 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Hi,
OFED-4.17-1-rc2 is available at:
http://openfabrics.org/downloads/OFED/ofed-4.17-1/OFED-4.17-1-rc2.tgz

Please report any issues in bugzilla
https://bugs.openfabrics.org/ for OFED 4.17-1-rc2

Release notes:
http://openfabrics.org/downloads/OFED/release_notes/OFED_4.17-1-rc2-release_notes

-------------------------------------------------------------------------------
OFED-4.17-1-rc2 Main Changes from OFED-4.17-1-rc1
-------------------------------------------------------------------------------
1. compat-rdma
- Module.supported: Added new Mellanox kernel modules

2. Updated packages
- rdma-core v17.5
- perftest-4.4-0.6.gba4bf6d
- opensm-3.3.22


Regards,
Vladimir
