Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1B3578342
	for <lists+linux-rdma@lfdr.de>; Mon, 29 Jul 2019 04:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbfG2CQb (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Jul 2019 22:16:31 -0400
Received: from mail-pf1-f171.google.com ([209.85.210.171]:41357 "EHLO
        mail-pf1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfG2CQb (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 28 Jul 2019 22:16:31 -0400
Received: by mail-pf1-f171.google.com with SMTP id m30so27176595pff.8;
        Sun, 28 Jul 2019 19:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=v7gMhfaXzQj2ttlXL3n3b9J2dA62pv8dP+adujB69Tc=;
        b=R1BUanzJhfnaO5aRBrpB7Up7A/v6wvhe/rS8r7qHQqRZFNGh/OVhnLuwVCvNk3Tlsb
         cdDLGAEXBTK7SbKmrITXJ9NHELfQFVo/wj2HP1w26GE5rzvjuLwBTJPEpmhHR3zX41ty
         mL5CsSjl8cPdtKyWyVoykJ3Ao32KyE05VDcOMQFKLmQRuJq2iEPIQA4G0aaYwX50oZNX
         ATwwByk6t7nOD/L3bZZKuU2css3zFui/dmVoLqjvaOcGuBbvi8nq6DKIXXzE4Laei7dj
         nFuobhC5q1PrPG3SNe3eAu535Va6BtFUAIVRy85ELnHjryDgpfF5l5YMu+KXW8OReABo
         nCBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=v7gMhfaXzQj2ttlXL3n3b9J2dA62pv8dP+adujB69Tc=;
        b=PuYXiVCYMEaGppiWV7dvmPQYuTeXtViK2HzCKVQgPVvHsoVTe6Qk5n8D+vIes/iRBT
         0ORbthhORNEhdY5gKJJQT8NVM6al0mw2cubQwu1ULHgUD+WWb4o260NPAribzF7zKjWE
         2KHB1/KsNkP1EvgF47W7xdyIx8FwdOsOL5UAptW45MhLJzUM+Q8B80ekV3mB6XcAGZXp
         hA7whb8MtV1eVy4OtjOWG1j6Z05A/DNEJ8mPiXn5UQ3gmTlBNJYGqGIer2mQKDdKs30G
         eaKUtD7nqLbvZwWdZAke7FN8cSBh4E3CDEP2fwKkhamQBhnLTBwoaHwzv28Axx9wmNP9
         GzyQ==
X-Gm-Message-State: APjAAAWvcAgkgX5w2JojFyaDxBGbFDQ+AEyu9lAAEupKv0oUdSQQSg80
        DWxM7gQRpaRjBmroUtvN3CRxfpW6
X-Google-Smtp-Source: APXvYqzhgdCgzjVqPfke8X9nFyqHLkUMbCPnoCohpw0l4SgEBYrZ/QSffdxjOmvgmRLmnlAw0khDbw==
X-Received: by 2002:a17:90a:d996:: with SMTP id d22mr109842800pjv.86.1564366590585;
        Sun, 28 Jul 2019 19:16:30 -0700 (PDT)
Received: from ?IPv6:2402:f000:4:72:808::177e? ([2402:f000:4:72:808::177e])
        by smtp.gmail.com with ESMTPSA id o24sm16112870pgn.93.2019.07.28.19.16.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 28 Jul 2019 19:16:30 -0700 (PDT)
To:     leon@kernel.org, dledford@redhat.com, jgg@ziepe.ca
Cc:     linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] infiniband: mlx5: a possible null-pointer dereference in
 set_roce_addr()
Message-ID: <f99031cc-795e-92bd-9310-29c669ada7dc@gmail.com>
Date:   Mon, 29 Jul 2019 10:16:30 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

In set_roce_addr(), there is an if statement on line 589 to check 
whether gid is NULL:
     if (gid)

When gid is NULL, it is used on line 613:
     return mlx5_core_roce_gid_set(..., gid->raw, ...);

Thus, a possible null-pointer dereference may occur.

This bug is found by a static analysis tool STCheck written by us.

I do not know how to correctly fix this bug, so I only report it.


Best wishes,
Jia-Ju Bai
