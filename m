Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 837A039E934
	for <lists+linux-rdma@lfdr.de>; Mon,  7 Jun 2021 23:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230394AbhFGVxf (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 7 Jun 2021 17:53:35 -0400
Received: from mail-oi1-f169.google.com ([209.85.167.169]:42639 "EHLO
        mail-oi1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230359AbhFGVxf (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 7 Jun 2021 17:53:35 -0400
Received: by mail-oi1-f169.google.com with SMTP id v142so19141371oie.9
        for <linux-rdma@vger.kernel.org>; Mon, 07 Jun 2021 14:51:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=XV8UNpucrCzRdAKbsRjSVbGmMu2s8pZIPqOoNm89hdw=;
        b=Rs0EyqA6k33/eTlQ9dD5IDmN3MbrRJuCKBnQ9x+LmnBgNd9MfTMi1rgs7teCu+mcZV
         5lhUraY4pwnKWEVba1j/jmSrZ2DWuJX5sOxYSjtn4sPowrFiMEHxuRiBuZDCqZI1ThsP
         CAD7721RK3EMlng2GIoBx4KUjK+lQ00eu7xr7I15n0dwDen8IMM/LSm+oRX4LpKzd2D8
         8hnZGlfo8SdnIpa7Dk6Rsxl+J4d5YRXUG8mhNp8TTVJbBHRWrUaZobe6TqzIF7vKXUhy
         7A5WgKvfhoRGW6M86DryqRrdftETsMn1qIckuXCho8mDVxlAbrep7qnMqwKvvSybq3F6
         N2ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=XV8UNpucrCzRdAKbsRjSVbGmMu2s8pZIPqOoNm89hdw=;
        b=jStdf2GtQH+axxLdMhhhd2V9Jhjk8+gDMwqGouPnxCRrxhHNDLmDylbvxOH7pY6sos
         W1RpVTQW3itk5Cpsrr9xxgDWJ8n5Vlz+Q6KsFUDPGl1uDr90k2o7uVJpSUddL8Iqbuh3
         PiXxm2AN65Qvybgbow0GW5gR3jK+V1gmEBc28p8TB3IWbxx0ip8i/sBqv2stMvaUAFA7
         bG6znWjv20nU58cFnWipgffJEQQpccPhSdM+dfK9vDgwRBgTLMBRdqIWEFuGxFWE2Q84
         xF/hj+auFoVD8wZHiiRT+fZP0dvq+JncnWyyGtcIK4xoVq0o8MH+NwOuxAhCu8CalZCD
         nSAQ==
X-Gm-Message-State: AOAM531tMY9SC1BJ128QyEsvD4lKLEZmb9yxZi/EmfobUy5/fna9Cxad
        M1L9FV8U2OVjoEo/hHDqWmN5GnekOps=
X-Google-Smtp-Source: ABdhPJxUTVFfuOFIY66POdefgJyz/mHTf5q62JTBM5bArTjijWNH5OhRfBpX2nTQA0Y76KsB3vQrIA==
X-Received: by 2002:aca:6106:: with SMTP id v6mr799347oib.175.1623102629358;
        Mon, 07 Jun 2021 14:50:29 -0700 (PDT)
Received: from [192.168.0.25] ([97.99.248.255])
        by smtp.gmail.com with ESMTPSA id d1sm2688725otu.9.2021.06.07.14.50.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Jun 2021 14:50:29 -0700 (PDT)
To:     Jason Gunthorpe <jgg@nvidia.com>,
        RDMA mailing list <linux-rdma@vger.kernel.org>
From:   "Pearson, Robert B" <rpearsonhpe@gmail.com>
Subject: [Bug Report] RDMA/core: test_qpex.py attempts invalid MW bind
 operation
Message-ID: <8d329494-6653-359b-91aa-31ac9dc8122c@gmail.com>
Date:   Mon, 7 Jun 2021 16:50:20 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

sorry/this time without the HTML.

======================================================================
ERROR: test_qp_ex_rc_bind_mw (tests.test_qpex.QpExTestCase)
Verify bind memory window operation using the new post_send API.
----------------------------------------------------------------------
Traceback (most recent call last):
   File "/home/rpearson/src/rdma-core/tests/test_qpex.py", line 292, in 
test_qp_ex_rc_bind_mw
     u.poll_cq(server.cq)
   File "/home/rpearson/src/rdma-core/tests/utils.py", line 538, in poll_cq
     raise PyverbsRDMAError('Completion status is {s}'.
pyverbs.pyverbs_error.PyverbsRDMAError: Completion status is Memory 
window bind error. Errno: 6, No such device or address

This test attempts to bind a type 2 MW to an MR that does not have bind 
mw access set and expects the test to succeed.

Bob Pearson

