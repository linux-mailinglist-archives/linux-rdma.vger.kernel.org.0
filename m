Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 397BCBBF36
	for <lists+linux-rdma@lfdr.de>; Tue, 24 Sep 2019 02:00:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391081AbfIXAAt (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Mon, 23 Sep 2019 20:00:49 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:33260 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388817AbfIXAAt (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Mon, 23 Sep 2019 20:00:49 -0400
Received: by mail-pf1-f195.google.com with SMTP id q10so10286254pfl.0;
        Mon, 23 Sep 2019 17:00:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=qobLklYPOKyR6+vhBCHo0Vd6NcYvjLRWaL7p2JkdEPA=;
        b=CY6+Qywm+wlt4uDPZKtIUjuMCyPvBDRLHoK8ycdJ6jPhLqc7tEY5wWWiqCJ4oGY7v6
         Mw2XRJ+JLxzB49qs8jYY151lHuORFIW3UEpUKRQ/P3XY4GN+x72dNbfRlMcNS5cyY7TK
         wwaKe6eLFTnhRMU4eks0Axob81lSGKiF7QhK4GohoiscDOzwtCC00Oyo6+rFuumfIh8a
         y7QnulKAEXYp0iBvvKaMH0gzMNRC/4CmGirGjfDlmYWC+r3Nr9bYIRM4CAKKV6gl/nCv
         0H+19bS1K+PBj5ySrDbDzcKY9JkNFSEhcJPQT708MlYOqt6gQYTYPRncRYwQDxJn9RE2
         XQVQ==
X-Gm-Message-State: APjAAAVeyNTQSlpciZepbPrr6Y7kOTM/aNtKaVR91ktu0deU7wYE2xfS
        1HdLTP7CXt8oY0p8sd9WEag=
X-Google-Smtp-Source: APXvYqzOn8C7guP0HZI+LvJ+0XASOwjoWe5ejZduT7XSYzXLBJr9uslb4GqpsnRN96qirmuSU1305Q==
X-Received: by 2002:a62:7790:: with SMTP id s138mr2369805pfc.57.1569283248696;
        Mon, 23 Sep 2019 17:00:48 -0700 (PDT)
Received: from desktop-bart.svl.corp.google.com ([2620:15c:2cd:202:4308:52a3:24b6:2c60])
        by smtp.gmail.com with ESMTPSA id f22sm11952244pjp.5.2019.09.23.17.00.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Sep 2019 17:00:47 -0700 (PDT)
Subject: Re: [PATCH v4 12/25] ibtrs: server: sysfs interface functions
To:     Jack Wang <jinpuwang@gmail.com>, linux-block@vger.kernel.org,
        linux-rdma@vger.kernel.org
Cc:     axboe@kernel.dk, hch@infradead.org, sagi@grimberg.me,
        jgg@mellanox.com, dledford@redhat.com,
        danil.kipnis@cloud.ionos.com, rpenyaev@suse.de,
        Roman Pen <roman.penyaev@profitbricks.com>,
        Jack Wang <jinpu.wang@cloud.ionos.com>
References: <20190620150337.7847-1-jinpuwang@gmail.com>
 <20190620150337.7847-13-jinpuwang@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
Message-ID: <456f046d-391e-2344-f61b-ba84290ff7b1@acm.org>
Date:   Mon, 23 Sep 2019 17:00:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190620150337.7847-13-jinpuwang@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

On 6/20/19 8:03 AM, Jack Wang wrote:
> +static void ibtrs_srv_dev_release(struct device *dev)
> +{
> +	/* Nobody plays with device references, so nop */
> +}

I doubt that the above comment is correct.

Thanks,

Bart.
