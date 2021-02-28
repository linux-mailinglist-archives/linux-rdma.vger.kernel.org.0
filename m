Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA2E3274B8
	for <lists+linux-rdma@lfdr.de>; Sun, 28 Feb 2021 23:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231397AbhB1WFJ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sun, 28 Feb 2021 17:05:09 -0500
Received: from mail-pf1-f174.google.com ([209.85.210.174]:45066 "EHLO
        mail-pf1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231246AbhB1WFJ (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Sun, 28 Feb 2021 17:05:09 -0500
Received: by mail-pf1-f174.google.com with SMTP id j12so10167348pfj.12;
        Sun, 28 Feb 2021 14:04:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=B7FKiKXAzqhJVBUKedXFnb556oEgUHUzV+54pjjDHGc=;
        b=piBombvn7zFjetMjxaOdP2AtKNd9B7n6cYaDAB9dcscnoeNEH7OuHfTGVy2cVgHb6i
         Pt/NN1Ccv9WJ7qy1qq5Km9sT+L2JfJW4Z9kJO12/t2pGPD+tiYTSzgzG+N1CXPXnPCr8
         qudqkgB+cBHBmsIZCO6QCk8WX1T5YTh7MfeGSYIeu06T7TCHJIXn7H5pEC1Rox1A8SqZ
         ONRHdHNGPk9RQ4lEqeCoBziPOBCLwq3v4ncoYQ/xA9aQjbFhnZSon9C35rfCNwngp3/I
         xWU1acNTIDVqZ0OzP75MsFcA3nX8EO3PXfqQxI36N2YjzKVMgF92dAFEuBC9EyiWybGI
         CW9A==
X-Gm-Message-State: AOAM5330QVavhaThVOLAQEZz1l9S+1h6hJ3cXaAv6KsZFWJm+1R+Iz3d
        x87kBpTrD8hfyqmxCUzCGW2iLrCdQB0=
X-Google-Smtp-Source: ABdhPJxXWjyovkCVp5h+pXTqXjHy4EPeWmxSGIIuYAaqVMXL7cqaBns+4vXkaK/rCPVzFet507Ncqg==
X-Received: by 2002:a65:6451:: with SMTP id s17mr2595344pgv.397.1614549867959;
        Sun, 28 Feb 2021 14:04:27 -0800 (PST)
Received: from ?IPv6:2601:647:4000:d7:33b2:579f:d8cd:be8a? ([2601:647:4000:d7:33b2:579f:d8cd:be8a])
        by smtp.gmail.com with ESMTPSA id r20sm13843194pgb.3.2021.02.28.14.04.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 28 Feb 2021 14:04:27 -0800 (PST)
Subject: Re: [bug report]null pointer at scsi_mq_exit_request+0x14 with
 blktests srp/015
To:     Yi Zhang <yi.zhang@redhat.com>, linux-scsi@vger.kernel.org,
        linux-rdma@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>
References: <418155251.14154941.1614505772200.JavaMail.zimbra@redhat.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <2457b558-bbb7-b6b8-1cb7-94fd833fc1a8@acm.org>
Date:   Sun, 28 Feb 2021 14:04:25 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <418155251.14154941.1614505772200.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 2/28/21 1:49 AM, Yi Zhang wrote:
> I found this issue with blktests srp/015, could anyone help check it?

Which kernel tree has been used in your tests? One of Linus' trees or a
for-next tree from a kernel maintainer?

Bart.
