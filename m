Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4D3AA18C745
	for <lists+linux-rdma@lfdr.de>; Fri, 20 Mar 2020 06:59:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726448AbgCTF7m (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Fri, 20 Mar 2020 01:59:42 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39421 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725446AbgCTF7m (ORCPT
        <rfc822;linux-rdma@vger.kernel.org>); Fri, 20 Mar 2020 01:59:42 -0400
Received: by mail-wr1-f66.google.com with SMTP id h6so5977207wrs.6
        for <linux-rdma@vger.kernel.org>; Thu, 19 Mar 2020 22:59:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=kDLDIz2XQ5PEBiALHiIAD2Xz5Iwic2FRHkLzD/AysdU=;
        b=p4XlRsdTAhU+Xn/bmvKl360PWxZE8dlOBcWvZYdEqPj0cVvYEYeKe/tXKwFxg9HIpm
         m5/x2muty08OLwWxmpmC0j6M+Gt/0ofjIEFhjeWYtXmQv0FJo37Uhq3yBiacd8tXs6JR
         hJCj7ZkDoUwLd6r08/uhrHTQSR7BkS5+wKrfWK89VHOvRi0+B1ePYBCPuhHv+oBSv6Zj
         F+VNTX+5hPUXYwsaMLxRbA7n4JXSLuEaZ2oNqzFj/6R78PH7sBZcwqoEhaJL6wJVJMMB
         EZQZlqX6RblyL386UfOF9nqmcdA9zuSwQKmq/9sIN121sXR2KjZUAGFSJsxxFbXuXcjj
         ENBA==
X-Gm-Message-State: ANhLgQ3g73qUvlXZpK2jewCTa3tXkQrnvLx4rgBYjmJzHT1NQyLfRk1c
        NXzDGWUAb++HwborNgDw7f31pAft
X-Google-Smtp-Source: ADFU+vuxjMcPhs79jFitCVj1e4zfnXASIijw1S3G/QU6r8G90wPjQKTI/sDCHTv90UjRBlD/m7x36A==
X-Received: by 2002:a05:6000:114f:: with SMTP id d15mr8986693wrx.143.1584683980246;
        Thu, 19 Mar 2020 22:59:40 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:f092:4ccc:3e48:6081? ([2601:647:4802:9070:f092:4ccc:3e48:6081])
        by smtp.gmail.com with ESMTPSA id p10sm7034420wrx.81.2020.03.19.22.59.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Mar 2020 22:59:39 -0700 (PDT)
Subject: Re: [PATCH v2 1/5] IB/core: add a simple SRQ pool per PD
To:     Max Gurtovoy <maxg@mellanox.com>, linux-nvme@lists.infradead.org,
        hch@lst.de, loberman@redhat.com, bvanassche@acm.org,
        linux-rdma@vger.kernel.org
Cc:     kbusch@kernel.org, leonro@mellanox.com, jgg@mellanox.com,
        dledford@redhat.com, idanb@mellanox.com, shlomin@mellanox.com,
        oren@mellanox.com, vladimirk@mellanox.com, rgirase@redhat.com
References: <20200318150257.198402-1-maxg@mellanox.com>
 <20200318150257.198402-2-maxg@mellanox.com>
From:   Sagi Grimberg <sagi@grimberg.me>
Message-ID: <b37caf65-a084-6ed2-2ee9-8a51a6e9b79d@grimberg.me>
Date:   Thu, 19 Mar 2020 22:59:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Firefox/60.0 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200318150257.198402-2-maxg@mellanox.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-rdma-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org


> ULP's can use this API to create/destroy SRQ's with the same
> characteristics for implementing a logic that aimed to save resources
> without significant performance penalty (e.g. create SRQ per completion
> vector and use shared receive buffers for multiple controllers of the
> ULP).

There is almost no logic in here. Is there a real point in having
in the way it is?

What is the point of creating a pool, getting all the srqs, manage
in the ulp (in an array), putting back, and destroy as a pool?

I'd expect to have a refcount for each qp referencing a srq from the
pool, and also that the pool would manage the srqs themselves.

srqs are long lived resources, unlike mrs which are taken and restored
to the pool on a per I/O basis...

Its not that I hate it or something, just not clear to me how useful it
is to have in this form...
