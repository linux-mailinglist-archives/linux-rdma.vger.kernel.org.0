Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCBB142443
	for <lists+linux-rdma@lfdr.de>; Mon, 20 Jan 2020 08:30:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726819AbgATHav (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 20 Jan 2020 02:30:51 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:40699 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgATHav (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 20 Jan 2020 02:30:51 -0500
Received: by mail-pl1-f193.google.com with SMTP id s21so12801278plr.7;
        Sun, 19 Jan 2020 23:30:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Tytd2xIi4rDm4xTJXT7PgUqxrt5vtfpID7x35/XLvLQ=;
        b=qgJoM5PzvBD4WIudxgVJpR0JpUL95t3+RV2VQF5DIC6J15eoPbPTxFy2SunYRCwuB6
         dLn/dcoPQSlzf3jEp9KeplHiElAI4h4Nf//fAp9u4rg+46Ve6S5jkuwwa55g7fdkXMUI
         rJTqpcBX7zkqM//iuzN/+IWClnMYYjzHAUPF7R2yOy+FAhzjVd4uTW4Q5O9xBzrDRYDO
         0YrOao7j3EhBZbQxfeXiGrem96y62PcR/xXWc4DBcwJJTpL0MhYyYmGp7Lc1+G+eOfDU
         18y5STnhQCkf3ImefRtd2h6x9DEtWibON0wWHHVILcVJqadj7xnDNjyi1o1cd2ZzzSOO
         qfww==
X-Gm-Message-State: APjAAAXjvLZE3ORpGd8K2UJAZWxXKv6RV83zlatiPpWX48dnfb3BzugK
        RdCaM6+rjWeIP9Dt7A/+aQOme3de
X-Google-Smtp-Source: APXvYqzDK6wx4LEDEg9emD5TiFnDsSjzz0adG10VLaUd3gMoKhJUt8CEO0Kge+r5ZYSORCoBtC5Rpw==
X-Received: by 2002:a17:902:9b90:: with SMTP id y16mr10637863plp.217.1579505450351;
        Sun, 19 Jan 2020 23:30:50 -0800 (PST)
Received: from ?IPv6:2601:647:4802:9070:fd41:47a6:c3c9:b0ce? ([2601:647:4802:9070:fd41:47a6:c3c9:b0ce])
        by smtp.gmail.com with ESMTPSA id w5sm35781930pgb.78.2020.01.19.23.30.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 19 Jan 2020 23:30:49 -0800 (PST)
Subject: Re: [PATCH] RDMA/isert: Fix a recently introduced regression related
 to logout
To:     Bart Van Assche <bvanassche@acm.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>
Cc:     target-devel@vger.kernel.org, linux-rdma@vger.kernel.org,
        Rahul Kundu <rahul.kundu@chelsio.com>
References: <20200116044737.19507-1-bvanassche@acm.org>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <97430396-5916-7913-d62f-b70cf174d465@grimberg.me>
Date:   Sun, 19 Jan 2020 23:30:48 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200116044737.19507-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Bart,

Acked-by: Sagi Grimberg <sagi@grimberg.me>
