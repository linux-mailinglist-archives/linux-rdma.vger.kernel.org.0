Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82589BE6AF
	for <lists+linux-rdma@lfdr.de>; Wed, 25 Sep 2019 22:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393418AbfIYUwN (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 25 Sep 2019 16:52:13 -0400
Received: from mail-ot1-f68.google.com ([209.85.210.68]:45695 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393339AbfIYUwN (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 25 Sep 2019 16:52:13 -0400
Received: by mail-ot1-f68.google.com with SMTP id 41so6081512oti.12
        for <linux-rdma@vger.kernel.org>; Wed, 25 Sep 2019 13:52:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=insDJwc6z7/UJZ1SUoCdibZ6Z6gv7esRUlZJH9gcsuXX+69E+1/I5PCFXyg2kTFZkK
         Li2iQwlR1qYzJOzy+kcnSSbz8fhzRT3YIZxceoYk7Ufx6+aJ5NJ2KXKIqzekNpqg1ogG
         sD8ynELRR8W0GotI+TePqbwCxkkJ1SXeKuuXazp2TcZ2g9s+WAozC/TA4iTVObEU1H9x
         gUVJ0/ed5lVAeUGTMoz7eunvt/ZCLA4v65wrJghtwxmYrEPnD/OrH+TpiQIrBjHkPEYd
         GaK35TPDg+hUqvDVtqPNjoD7YvlgrUIwl3CFX9rGkoUKPbkZmDCxOJcH0uyUE1HwO8ID
         LuFg==
X-Gm-Message-State: APjAAAVok+TZphY+4B0wiQ4XowtBdk3T+usU+07mJ8vOuvFg/qyhVRU5
        JmoEkCu5by1GznWJDwNCLnc=
X-Google-Smtp-Source: APXvYqxBcBVdIHlx4IlC5iEi65mICMjwqJNlsrcBvYWfAyoCR36KoK3ljjmgupSX4Mh4BcIE9XQZRw==
X-Received: by 2002:a9d:378a:: with SMTP id x10mr68356otb.222.1569444732325;
        Wed, 25 Sep 2019 13:52:12 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id y8sm19645oig.55.2019.09.25.13.52.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 25 Sep 2019 13:52:11 -0700 (PDT)
Subject: Re: [PATCH 1/1] IB/iser: bound protection_sg size by data_sg size
To:     Max Gurtovoy <maxg@mellanox.com>, jgg@mellanox.com,
        linux-rdma@vger.kernel.org, dledford@redhat.com,
        leonro@mellanox.com
Cc:     martin.petersen@oracle.com
References: <1569359027-10987-1-git-send-email-maxg@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <e6cfe04e-5fcc-0c43-c254-946e770db0bc@grimberg.me>
Date:   Wed, 25 Sep 2019 13:52:10 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1569359027-10987-1-git-send-email-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
