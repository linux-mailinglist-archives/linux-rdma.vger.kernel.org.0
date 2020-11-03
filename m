Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1752A5ACB
	for <lists+linux-rdma@lfdr.de>; Wed,  4 Nov 2020 00:55:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728712AbgKCXzA (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Tue, 3 Nov 2020 18:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgKCXzA (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Tue, 3 Nov 2020 18:55:00 -0500
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33F6C0613D1
        for <linux-rdma@vger.kernel.org>; Tue,  3 Nov 2020 15:54:59 -0800 (PST)
Received: by mail-oi1-x235.google.com with SMTP id w145so14637184oie.9
        for <linux-rdma@vger.kernel.org>; Tue, 03 Nov 2020 15:54:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=5wMaTbJo7M349roI6AfdxPHA8d4dW1qcN/rcY30wI8I=;
        b=MSmE50zpJrUqQX/PVzWMJN6Q4fc+V1uoceFfzd+WQhxGhttA3ZGkLme5vfj3xF2k5S
         rGf9OWmaWOcNP9Zzt1UyyFW9pNJN3Rel4PT7xZL5EumHaS5HB2sFHf5Cu748cxZ3c6ge
         ZtIzKKZJxsfRppYVNrQKiuaUmoT82pOpiJaIyR0zwlVRV/BIKLYitTYSN6ou4OJGqv1f
         Hox3+7H4pCxHUN2RS0ob5ebiU16zrMT4kdy+Zrmuy49C4Sgxg92K1QOQHtuKVGZo5/dY
         wofQjaujYIz8Ngdp8DRhIfAW7Iusl8EBf4g2onsQHqCoQ5ahcdUqul2IbD7HFllNcpPa
         4zWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=5wMaTbJo7M349roI6AfdxPHA8d4dW1qcN/rcY30wI8I=;
        b=edysDLimtFX3PkmRZZL7ypDG9+wZS24xfMa3cd/x297XROUnYn3pMQx3YAT6uwWDyN
         MWlqdwzah9efEdq9dUjGvDnHgu3av8/aqoqe5ERdzOP+TxQBr3TB3sq4ZhjAb5DWIt2M
         FasZ56Sr9nd/T7grgP0eoceDMBNMmnSkpxRb41nKrVuMrJlEFn3CgOGmayeoYJvF43pl
         Xsc1EgQoB+ZRccXf1qyc0oeVoJKNIWsTaXpIt4L3RsVZeAB0Z9bpz0MOnqUCguSQJvhM
         3HWVl5As5TfCaB6aXVgNOLLDchLLz3+9rpRSyOxKtXl6qX+MyWrb53YgIaMGlIOUY8XR
         yT8w==
X-Gm-Message-State: AOAM533jvpCfL9U4+vCsF8gn0fIw76kXxA7jbFXH34Ga467o/y1CaDe7
        XCstp4ivOqFatAdYOyWy+1ftXCI9tzM=
X-Google-Smtp-Source: ABdhPJzk41C/xoGn4Wsvgp6K/FBrC+RlhuYEbslWQ+pFvLIlE3R+eczegDFXrksMoiRkdUV+o6Ctmg==
X-Received: by 2002:aca:3dd4:: with SMTP id k203mr992025oia.86.1604447699209;
        Tue, 03 Nov 2020 15:54:59 -0800 (PST)
Received: from ?IPv6:2603:8081:140c:1a00:1c77:3258:9ca4:99ae? (2603-8081-140c-1a00-1c77-3258-9ca4-99ae.res6.spectrum.com. [2603:8081:140c:1a00:1c77:3258:9ca4:99ae])
        by smtp.gmail.com with ESMTPSA id b123sm55862oii.47.2020.11.03.15.54.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Nov 2020 15:54:58 -0800 (PST)
To:     Jason Gunthorpe <jgg@nvidia.com>, Leon Romanovsky <leon@kernel.org>
Cc:     "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>
From:   Bob Pearson <rpearsonhpe@gmail.com>
Subject: pyverbs test regression
Message-ID: <f8de77b3-d9c7-5b0f-c118-c95f0c6a271c@gmail.com>
Date:   Tue, 3 Nov 2020 17:54:58 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Since 5.10 some of the pyverbs tests are skipping with the warning
	"Device rxe_0 doesn't have net interface"

These occur in tests/test_rdmacm.py. As far as I can tell the error occurs in

RDMATestCase _add_gids_per_port after the following

	    if not os.path.exists('/sys/class/infiniband/{}/device/net/'.format(dev)):
                self.args.append([dev, port, idx, None])
                continue

In fact there is no such path which means it never finds an ip_addr for the device.

Did something change here? Do other RDMA devices have /sys/class/infiniband/XXX/device/net?

Thanks,

Bob Pearson
