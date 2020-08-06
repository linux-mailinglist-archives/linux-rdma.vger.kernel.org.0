Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 647ED23E2EA
	for <lists+linux-rdma@lfdr.de>; Thu,  6 Aug 2020 22:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726131AbgHFUMK (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Thu, 6 Aug 2020 16:12:10 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38652 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbgHFUMK (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Thu, 6 Aug 2020 16:12:10 -0400
Received: by mail-pj1-f65.google.com with SMTP id ep8so7252816pjb.3
        for <linux-rdma@vger.kernel.org>; Thu, 06 Aug 2020 13:12:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+KhrMhcJSvItbb/04gtqwcqQ9SN2qd7j6u0HCMyKS6E=;
        b=eTiRlsyzN48ZQZD6BOgjCP0zIiTA0cJny0Mp2rMCS4ZBC/QRof+HONTwfH0noBoP7k
         r1lC9b9vBXZjQAX4LFROYcOX9mtgEhT/tzmJXjxWsisX6247chFy9qCqcB4beRWczc+t
         CjbxtqXppt7MO0ktvC/p1NFZeaF/p2IJHtuT+yoACaXKf+Zy8RxpTnA5JcR6empqa+xF
         iUaD6smrj4pW1tRY3DfJFn/lNk3cAISz1beEwCMP7goCxBnvZU4jmaA5/kS+JTz0BPMG
         9MfFF+pIcT32CLvSSvkXZa7cmsJw47RBhfcIh4DK14JmTodK20UQOJKDEW7JCACvPWH3
         cC/w==
X-Gm-Message-State: AOAM533AhPmrqNU9ELoeJdnYYe8DwAc+qklOeY49og7dU1+gmpSYcipR
        Yg3kd7YEsiY0RwnSZsb0psQ=
X-Google-Smtp-Source: ABdhPJy7Peyn/QrNQCdQqxjZnPfuDGXL8J4BQmQZdAMwMgXUtdoMCy4KPL5IsNZFNq7i+NdSLTNMkw==
X-Received: by 2002:a17:90b:194d:: with SMTP id nk13mr9395576pjb.220.1596744729550;
        Thu, 06 Aug 2020 13:12:09 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:d88d:857c:b14c:519a? ([2601:647:4802:9070:d88d:857c:b14c:519a])
        by smtp.gmail.com with ESMTPSA id 132sm2192704pgg.83.2020.08.06.13.12.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Aug 2020 13:12:08 -0700 (PDT)
Subject: Re: [PATCH 2/2] IB/isert: remove duplicated error prints
To:     Max Gurtovoy <maxg@mellanox.com>, linux-rdma@vger.kernel.org,
        jgg@nvidia.com, jgg@mellanox.com, dledford@redhat.com,
        leonro@mellanox.com
Cc:     oren@mellanox.com
References: <20200805121231.166162-1-maxg@mellanox.com>
 <20200805121231.166162-2-maxg@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <80edcc4b-713e-e870-2f5e-71f90dad6cf7@grimberg.me>
Date:   Thu, 6 Aug 2020 13:12:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805121231.166162-2-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

Acked-by: Sagi Grimberg <sagi@grimberg.me>
