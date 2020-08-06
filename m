Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 671DB23E26F
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Aug 2020 21:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgHFTni (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Aug 2020 15:43:38 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:43811 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgHFTnh (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Aug 2020 15:43:37 -0400
Received: by mail-pf1-f195.google.com with SMTP id y206so15375949pfb.10
        for <linux-rdma@vger.kernel.org>; Thu, 06 Aug 2020 12:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ZYTOD//m2nC4EN93f2A1/RVEi/iNsIAxDic3kiZ+8AE=;
        b=Tpd5YmO7hUYF8zTlqLs0SLHCMW5EfMRmDt5AG54e1EszqAXWryk6uOvU/XsQxn11QN
         9AhaiBRUqNsRDpMYmjlXtXbHM5hhsqDe+6SlOMDe3S+TpQ1tzJZsTpUKG1iktFv9T+VX
         gFBtm190Lvk9YWCzjfg9K0rfyZXSpDP+kCCPKYIircEEK2q/TEwi82LXsOmMdHdfUByI
         FunyK0zx5OgoHepCaAr9IDr8XV5axIs+JB3Eui87jeYQz4vtTAaGwbVZdcsAAoMgtuz4
         oq3SyrOW94G7LNgxGZ5MFcj7evXbHR/CVoi17ETqT5V8HpXfwhhbEV7UfZSsIhXrDvfg
         llmQ==
X-Gm-Message-State: AOAM532Vu1kYFBMnk5qX3ZTfiFq7Z6+JrGJ99fwI5SHe9ytlwbNFXcgV
        CxZ+vgznnQMTkTc4/Wj17Cw=
X-Google-Smtp-Source: ABdhPJzoVVOboBn7x12qrVTxC+jvoIIKii9noM3xZHYQVSSk49TgxJCDMtiD+uG9gzwl5vFakngI0w==
X-Received: by 2002:aa7:8751:: with SMTP id g17mr9559391pfo.109.1596743016608;
        Thu, 06 Aug 2020 12:43:36 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d88d:857c:b14c:519a? ([2601:647:4802:9070:d88d:857c:b14c:519a])
        by smtp.gmail.com with ESMTPSA id a13sm9163050pfo.49.2020.08.06.12.43.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 12:43:35 -0700 (PDT)
Subject: Re: [PATCH 1/2] IB/isert: use unlikely macro in the fast path
To:     Max Gurtovoy <maxg@mellanox.com>, linux-rdma@vger.kernel.org,
        jgg@nvidia.com, jgg@mellanox.com, dledford@redhat.com,
        leonro@mellanox.com
Cc:     oren@mellanox.com
References: <20200805121231.166162-1-maxg@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <545cfafd-bb4c-0922-b0af-a34e8b67daf2@grimberg.me>
Date:   Thu, 6 Aug 2020 12:43:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805121231.166162-1-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Looks fine,

Acked-by: Sagi Grimberg <sagi@grimberg.me>
