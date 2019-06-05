Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 39FBF364BF
	for <lists+linux-rdma@lfdr.de>; Wed,  5 Jun 2019 21:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726461AbfFETct (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Wed, 5 Jun 2019 15:32:49 -0400
Received: from mail-ot1-f47.google.com ([209.85.210.47]:41575 "EHLO
        mail-ot1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726280AbfFETct (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Wed, 5 Jun 2019 15:32:49 -0400
Received: by mail-ot1-f47.google.com with SMTP id 107so1825710otj.8
        for <linux-rdma@vger.kernel.org>; Wed, 05 Jun 2019 12:32:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xoY7ArDsWjB4cgYM05leItiksDVbZ03cFnFs2b6O/pA=;
        b=Uk8gUJzn40ymY1xLucKfBQLJ/QWb5/j0f0p/ulOF/OKVThmn7BIHuBsa/tBcRNJaMl
         yL+ZGWAwndCxyVRNDNzHxqqODrBRY3m+HMzeBiVAISK6MFLBeK8AIAuRAxD9HNG8rAqx
         WqETb61UjoRTB7vD+CSD3VDg6NUqPeWzu1+zm5bgZ9wnRCtWKdI0FsalxVUjTuGchgtF
         SUMevZqnSKZBsNNxRIiEYzQpD19oMw05VS+65kAlnmsJRONOBGLXf3AkBl35HTewRNWO
         RZOU4yIHXmVMnoZizd8b+DCUFZSHTsLv94pLu0x8UdT4PqeNgkOqlk0UtrIQLghdO4OY
         mF7A==
X-Gm-Message-State: APjAAAXilpqpfpz865wi8wCg2IDLQn8Ni65CzGabuePJzxwq+5cY56Q3
        2MoiE51CZooMjtZEslt2rN0=
X-Google-Smtp-Source: APXvYqw3986VP3RO4IvKuuxqN8BhWVfZ9Iq4U2cAZ5qrF1An+lKCathq1mMzdRSFwfDd2kGjgcq1Og==
X-Received: by 2002:a05:6830:1003:: with SMTP id a3mr5260072otp.192.1559763166392;
        Wed, 05 Jun 2019 12:32:46 -0700 (PDT)
Received: from ?IPv6:2600:1700:65a0:78e0:514:7862:1503:8e4d? ([2600:1700:65a0:78e0:514:7862:1503:8e4d])
        by smtp.gmail.com with ESMTPSA id r7sm7772967oia.22.2019.06.05.12.32.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jun 2019 12:32:45 -0700 (PDT)
Subject: Re: [PATCH 11/20] IB/iser: Use IB_WR_REG_MR_INTEGRITY for PI handover
To:     Max Gurtovoy <maxg@mellanox.com>, Christoph Hellwig <hch@lst.de>
Cc:     leonro@mellanox.com, linux-rdma@vger.kernel.org, jgg@mellanox.com,
        dledford@redhat.com, bvanassche@acm.org, israelr@mellanox.com,
        idanb@mellanox.com, oren@mellanox.com, vladimirk@mellanox.com,
        shlomin@mellanox.com
References: <1559222731-16715-1-git-send-email-maxg@mellanox.com>
 <1559222731-16715-12-git-send-email-maxg@mellanox.com>
 <20190604074300.GP15680@lst.de>
 <0739949f-a069-289a-576b-d9253acc4d6e@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3f1a2744-c672-f572-00b9-cd86210be1a7@grimberg.me>
Date:   Wed, 5 Jun 2019 12:32:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <0739949f-a069-289a-576b-d9253acc4d6e@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


>> On something very vaguely related:  Can one of you look into dropping
>> FMR support in iser/isert now that NFS as the other major user has
>> dropped support as well?
> 
> Yes I think we mentioned this. Sagi has patches for that and we'll merge 
> it on top of this series.

Yes, I had some plans for that...
