Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 154645BD6A
	for <lists+linux-rdma@lfdr.de>; Mon,  1 Jul 2019 15:57:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727381AbfGAN5n (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 1 Jul 2019 09:57:43 -0400
Received: from mail-wr1-f53.google.com ([209.85.221.53]:34233 "EHLO
        mail-wr1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbfGAN5m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 1 Jul 2019 09:57:42 -0400
Received: by mail-wr1-f53.google.com with SMTP id u18so5830113wru.1
        for <linux-rdma@vger.kernel.org>; Mon, 01 Jul 2019 06:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dev-mellanox-co-il.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=e0d1IYolFFV+a24izQKFfjol+b/dm+s09WH1SXc42cY=;
        b=SulPiu+CswgO1LNN2Gu3kT6wz2HfsH18iSb7KXGE3atYG5NOVXTSmfXAFCf8lIv7lz
         XX/CKjdkXJzK61NWgbKSu51X6li88WWY7CGAR4VsBpro11aw8yUPptvmExuNLB9S2GNz
         2I29DONSs0WcHRxHOavFOcyLRHhKJ9rUzDOCx2kh16lIHSDpCa97ukoRdpGQdVC3WHMd
         dF6z9rZwSoDgi5x8OWQ6Wu9z8oxebH56hnplh+wGA5cqrvg1g6SXtc1BiVol6PEoam8Z
         F+k0Zt+tj1TvHZIG4325rxSVy759AD/FxW6d1KtodklMygmHkArnCxml/bOt4ezOAFkW
         qbCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=e0d1IYolFFV+a24izQKFfjol+b/dm+s09WH1SXc42cY=;
        b=CvUN2TNK+Esigw5rdJkBW5wh+gka9D60XS9DoHgO7Dx1M59Jvf0hz0Z6k7TlBNbbQF
         th4Er/sFggeHX5hGfeHVrBJBLwcGEydZ5wo6apSwxWRxDkeKwf4csHj3YULT339xbzph
         A+C4rqlXwSiqMADOV/Jm0D3Ur0mw7PWS3XB7dOxLThNlcHm/H8czcZUedqgCqymGyQJZ
         g6KsuY7BmCvZZiwIoQRbK6Vh1kNwywuJi9+eAQSsIvsNY7W+gG8Ry6d7gCFHl+QG1SWW
         FxWF+JqyT+TQLahR9nBzLztBJa/DzMH3vRzdc27ESuIqpmXQ5BhFr1OfcJOXbdoFRJvh
         n98w==
X-Gm-Message-State: APjAAAVWp6KZybuoRMLLUgCwsTtdzBmfyvvHgK+uibnR51Cf6FYjCucK
        200jBD3Afq2phLYaBmjEx4LPkmGIlLI=
X-Google-Smtp-Source: APXvYqw6bfLkydfQV7YY9ugz4j8Ng8e+ykroUKdmieVSh9zsYBPPCv2o7bkWxZBklEhruOVknNGdiA==
X-Received: by 2002:adf:a143:: with SMTP id r3mr9836697wrr.352.1561989460553;
        Mon, 01 Jul 2019 06:57:40 -0700 (PDT)
Received: from [10.128.129.210] ([141.226.120.58])
        by smtp.gmail.com with ESMTPSA id c1sm21811254wrh.1.2019.07.01.06.57.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jul 2019 06:57:40 -0700 (PDT)
From:   Vladimir Sokolovsky <vlad@dev.mellanox.co.il>
Subject: [ANNOUNCE] OFED 4.17-1 GA release is available
To:     "ewg@lists.openfabrics.org" <ewg@lists.openfabrics.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
Message-ID: <bc645a23-c951-59d5-e6f7-81b20652de1c@dev.mellanox.co.il>
Date:   Mon, 1 Jul 2019 16:56:28 +0300
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
OFED-4.17-1 is available at:
http://openfabrics.org/downloads/OFED/ofed-4.17-1/OFED-4.17-1.tgz
To get BUILD_ID run ofed_info

Please report any issues in bugzilla
http://bugs.openfabrics.org/bugzilla/ for OFED 4.17-1

Release notes:
http://openfabrics.org/downloads/OFED/release_notes/OFED_4.17-1-release_notes

-------------------------------------------------------------------------------
OFED-4.17-1-GA Main Changes from OFED-4.17
-------------------------------------------------------------------------------
1. Add support for RHEL7.6 and SLES12 SP4

2. compat-rdma
- Module.supported: Added new Mellanox kernel modules
- bnxt_en: Fix bnxt_en compilation for RH 7.6
- Add vmw_pvrdma patch from linux-next
- compat: Move bpf_prog_sub to be exported by compat

3. Updated packages
- rdma-core v17.5
- perftest-4.4-0.6.gba4bf6d
- opensm-3.3.22
- mstflint-4.11.0-4
- libfabric-1.7.1
- fabtests-1.7.1

4. ofed-scripts
- install.pl: Updated rdma-core requirements
- install.pl: Disable compat-rdma-firmware on SLES12SP4 due to conflict
- install.pl: Added SLES12 SP4 support
- install.pl: Added RHEL7.6 support
- install.pl: Added openssl-devel requirement for mstflint


Regards,
Vladimir
