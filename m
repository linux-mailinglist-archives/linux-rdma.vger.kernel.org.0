Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDD53ABE4F
	for <lists+linux-rdma@lfdr.de>; Thu, 17 Jun 2021 23:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbhFQVoR (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 17 Jun 2021 17:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbhFQVoQ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 17 Jun 2021 17:44:16 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A61C061574
        for <linux-rdma@vger.kernel.org>; Thu, 17 Jun 2021 14:42:07 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id w127so8122414oig.12
        for <linux-rdma@vger.kernel.org>; Thu, 17 Jun 2021 14:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:references:to:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=YW+g3DZRjIQrRe2fkfjgMMqsyJhOPiI3q0WYtydz6TA=;
        b=Zcbdc72yEvyI9DL2vX8p9pFlwUJ+MXNwm68zVs3AqM6wNtFWxxSOjqccJOWGt2erG5
         CfqsgijVTIMVWZVhXqkxwLFGaLGyu4LCTLpmMv1MhA9SaFsHRRs+vlRmA3R2yL5PPLKt
         NsDf4yt+kJuwr5CV/0CWvsv4dVhR4MedSRBhTlZgDrlPVyZxpniZpqu7+KgZxsF3i9pK
         yU/JKzEmKOBoo2G19IPSfBYYy/m4da5i7yz1shYez11r6Ofxhf72LEcPIqGRIUZWzCgx
         4ILzu375S3fwHUjI2rl9mhoHxK22aNI1/cG4rFwnrX/de+oNKB/i39r8n4e5AXjMV2Jl
         njXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:references:to:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=YW+g3DZRjIQrRe2fkfjgMMqsyJhOPiI3q0WYtydz6TA=;
        b=Ghl2WA8sntjMbEA69sOd6eQSxyP3YSWgfJ/kSXG71N9THTWfNEQp7GRtA6o+Ozxqew
         vNvQnL+R9YojF+zp25eZtOkF2NcjX+7HfkR3sDdIOCi/nmX/rGuB6wQdl0QmUVc5Wi+V
         PwZdEkeANBQk76yhrkNgWh4Qcw5Dqeeg7oN17p0WyTUJzor+U1fKzr44rHee6NSF+BIJ
         aATbLGg0BM0EXIyDa7t4YK9fAG6Cf6nypXXEV3+WDggM3F/naMcWrCTmM7boADrNWncJ
         er3O6rPHYkfMFTmqjyT9GFF3O4DPWoenv9Wh7SB55uRFDDwC03iLs5MdFSuMoSbMSHKE
         bP4A==
X-Gm-Message-State: AOAM5335f86DlbvGkg0fW3wa6478K2jrUEwNZxT0/Vb00uZrGAwkYy6I
        OBWwN5L2ByCuD70EVoBoJA0KzMhDgYo=
X-Google-Smtp-Source: ABdhPJypy9NaLMn5g8hivAX0oEzQ1fiB/U7AlCHUebDImR2PurEWOWeNIHHfbhjkIshU/p4n6A27Ug==
X-Received: by 2002:a05:6808:1491:: with SMTP id e17mr1035881oiw.132.1623966126955;
        Thu, 17 Jun 2021 14:42:06 -0700 (PDT)
Received: from ?IPv6:2603:8081:140c:1a00:62ce:b5dc:8263:18a7? (2603-8081-140c-1a00-62ce-b5dc-8263-18a7.res6.spectrum.com. [2603:8081:140c:1a00:62ce:b5dc:8263:18a7])
        by smtp.gmail.com with ESMTPSA id c64sm1396479oif.30.2021.06.17.14.42.06
        for <linux-rdma@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Jun 2021 14:42:06 -0700 (PDT)
Subject: Fwd: RDMACM Python test cases
References: <11c7eeef-a76b-08b2-3c78-61792332e1b9@gmail.com>
To:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
X-Forwarded-Message-Id: <11c7eeef-a76b-08b2-3c78-61792332e1b9@gmail.com>
Message-ID: <1ec1bc83-328f-f08c-82c7-96ef8e1d5b22@gmail.com>
Date:   Thu, 17 Jun 2021 16:42:06 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <11c7eeef-a76b-08b2-3c78-61792332e1b9@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org




-------- Forwarded Message --------
Subject: RDMACM Python test cases
Date: Thu, 17 Jun 2021 16:40:31 -0500
From: Bob Pearson <rpearsonhpe@gmail.com>
To: Edward Srouji <edwards@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, Zhu Yanjun <zyjzyj2000@gmail.com>, linux-rdma@vger.linux.org

Edward,

Currently all the RDMACM python test cases in rdma-core fail on the rxe driver. They can be made to pass but I am not sure it is the correct way. It is

Before calling ib_register_device() set the ib_device>device>parent pointer to point at the PCIe bus device that is the parent of the network device that is being used to carry soft RoCE packets. Then the kernel will create /sys/class/infiniband/rxe_<N>/device/net/<NDEV> in the kobject tree.

This makes all the python RDMACM tests pass. But, it makes libibverbs complain if there are other RDMA devices used as NDEVs for rxe. For example running rxe over mlx5 (using a fake UDP dport) breaks. There seem to be a lot of assumptions being made about the /sys file system that can fail. Like there is only one device in device/net and there is only one device in device/infiniband.

The reason the python tests fail is that there is code that attempts to a) discover the network device name from /sys and b) then use % ip addr dev name ... to discover the IP address. For rxe there is another way to do this that doesn't need ...rxe_<N>/device/net... by using % rdma link which gives a list of rdma devices and matching ndevs. It seems to me that it should be fairly easy to fall back to this if the test for /sys/class/infiniband/{}/device/net fails.

Regards,

Bob Pearson
