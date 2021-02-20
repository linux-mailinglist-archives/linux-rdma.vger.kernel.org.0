Return-Path: <linux-rdma-owner@vger.kernel.org>
X-Original-To: lists+linux-rdma@lfdr.de
Delivered-To: lists+linux-rdma@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0425320726
	for <lists+linux-rdma@lfdr.de>; Sat, 20 Feb 2021 22:05:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229810AbhBTVEQ (ORCPT <rfc822;lists+linux-rdma@lfdr.de>);
        Sat, 20 Feb 2021 16:04:16 -0500
Received: from btbn.de ([5.9.118.179]:59772 "EHLO btbn.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229804AbhBTVEO (ORCPT <rfc822;linux-rdma@vger.kernel.org>);
        Sat, 20 Feb 2021 16:04:14 -0500
Received: from [IPv6:2001:16b8:6442:9000:9c32:4459:3dca:c2e1] (200116b8644290009c3244593dcac2e1.dip.versatel-1u1.de [IPv6:2001:16b8:6442:9000:9c32:4459:3dca:c2e1])
        by btbn.de (Postfix) with ESMTPSA id A9AF21EA093;
        Sat, 20 Feb 2021 22:03:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rothenpieler.org;
        s=mail; t=1613855011;
        bh=v6IZtritFyozXbzd9UFCpDoArLKW25tNrtQk2RHO4Zg=;
        h=Subject:To:Cc:References:From:Date:In-Reply-To;
        b=e3Pmd7syRFMK+UNnTz9+GCbbPjxcBDIscd6QNfcIF/kpMIoXLzX5mLHon0ap3sQ/c
         JQ0xjDnbzILDjw3sftYrqcQXTvC0pfFcjQdga83sdREihN/trjllfDmttotWIMNBIk
         EuYe4RVRPoxhJGw5hT5hC6ydG/W/jlfNyEJt7CXfrav5IWwu3CIDxQJWTT+5M9SIif
         cgjnrqfkPnCKeMcpQe6+2dj9ghtoXeCXKKfj/ILcc+jWp4vaAYc8qacM5TjREC/gel
         bTk1hhB6UcIb2WeHc/xoc3P8Bi7PwtRGe09xtAFh+hwk9EBjVmulatisfRyWBehWGr
         /kOT4MR4eb8iw==
Subject: Re: copy_file_range() infinitely hangs on NFSv4.2 over RDMA
To:     Chuck Lever <chuck.lever@oracle.com>,
        Olga Kornievskaia <aglo@umich.edu>
Cc:     linux-rdma <linux-rdma@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
References: <57f67888-160f-891c-6217-69e174d7e42b@rothenpieler.org>
 <CAN-5tyE4OyNOZRXGnyONcdGsHaRAF39LSE5416Kj964m-+_C2A@mail.gmail.com>
 <81cb9aef-c10d-f11c-42c0-5144ee2608bc@rothenpieler.org>
 <0e49471c-e640-a331-c7b4-4e0a49a7a967@rothenpieler.org>
 <CAN-5tyG9Ly9tqKxguFNhg_PGXCxE2=Zn6LQPLY59twdVkD3Auw@mail.gmail.com>
 <51a8caa7-52c2-8155-10a7-1e8d21866924@rothenpieler.org>
 <CAN-5tyFT4+kkqk6E0Jxe-vMYm7q5mHyTeq0Ht7AEYasA30ZaGw@mail.gmail.com>
 <3f946e6b-6872-641c-8828-35ddd5c8fed0@rothenpieler.org>
 <e89ab742-7984-6a2c-2f01-402283ba6e89@rothenpieler.org>
 <CAN-5tyGhyh0ZF77voaN4TNgMt+jSUG0PMp-KixfTvgUhDdhDUQ@mail.gmail.com>
 <def12560-2481-b17d-5a42-7236edbd5392@rothenpieler.org>
 <CAN-5tyHLRn4HEs9R291N6Y=boOvQ9-qvKfJzA8Khkqie2kVVWQ@mail.gmail.com>
 <6478B738-0C33-46DC-B711-B0BF7069FD82@oracle.com>
 <19c74710-bf35-6412-dd06-071331419ab5@rothenpieler.org>
 <E4BAC726-2FFA-47A8-A1B6-F0D2848ABB98@oracle.com>
From:   Timo Rothenpieler <timo@rothenpieler.org>
Message-ID: <14ca46ac-6b3f-5e51-e4f6-bf4d5dc9933b@rothenpieler.org>
Date:   Sat, 20 Feb 2021 22:03:29 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <E4BAC726-2FFA-47A8-A1B6-F0D2848ABB98@oracle.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256; boundary="------------ms090801090503060000030808"
Precedence: bulk
List-ID: <linux-rdma.vger.kernel.org>
X-Mailing-List: linux-rdma@vger.kernel.org

This is a cryptographically signed message in MIME format.

--------------ms090801090503060000030808
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 19.02.2021 19:48, Chuck Lever wrote:
>=20
>=20
>> On Feb 19, 2021, at 1:01 PM, Timo Rothenpieler <timo@rothenpieler.org>=
 wrote:
>>
>> On 19.02.2021 18:48, Chuck Lever wrote:
>>>> On Feb 19, 2021, at 12:38 PM, Olga Kornievskaia <aglo@umich.edu> wro=
te:
>>>>
>>>> On Thu, Feb 18, 2021 at 3:22 PM Timo Rothenpieler <timo@rothenpieler=
=2Eorg> wrote:
>>>>>
>>>>> On 18.02.2021 19:30, Olga Kornievskaia wrote:
>>>>>> Thank you for getting tracepoints from a busy server but can you g=
et
>>>>>> more? As suspected, the server is having issues sending the callba=
ck.
>>>>>> I'm not sure why. Any chance to turn on the server's sunrpc
>>>>>> tracespoints, probably both sunrpc and rdmas tracepoints, I wonder=
 if
>>>>>> we can any more info about why it's failing?
>>>>>
>>>>> I isolated out two of the machines on that cluster now, one acting =
as
>>>>> NFS server from an ext4 mount, the other is the same client as befo=
re.
>>>>> That way I managed to capture a trace and ibdump of an entire cycle=
:
>>>>> mount + successful copy + 5 minutes later a copy that got stuck
>>>>>
>>>>> Next to no noise happened during those traces, you can find them at=
tached.
>>>>>
>>>>> Another observation made due to this: unmount and re-mounting the N=
FS
>>>>> share also gets it back into working condition for a while, no rebo=
ot
>>>>> necessary.
>>>>> During this trace, I got "lucky", and after just 5 minutes of waiti=
ng,
>>>>> it got stuck.
>>>>>
>>>>> Before that, I had a run of mount + trying to copy every 5 minutes =
where
>>>>> it ran for 45 minutes without getting stuck. At which point I decid=
ed to
>>>>> remount once more.
>>>>
>>>> Timo, thank you for gathering the debug info.
>>>>
>>>> Chuck, I need your help. Why would the server lose a callback channe=
l?
>>>>
>>>>            <...>-1461944 [001] 2076465.200151: rpc_request:
>>>> task:57752@6 nfs4_cbv1 CB_OFFLOAD (async)
>>>>            <...>-1461944 [001] 2076465.200151: rpc_task_run_action:
>>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>>> runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_reserve
>>>>            <...>-1461944 [001] 2076465.200154: xprt_reserve:
>>>> task:57752@6 xid=3D0x00a0aaf9
>>>>            <...>-1461944 [001] 2076465.200155: rpc_task_run_action:
>>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>>> runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_reserveresult
>>>>            <...>-1461944 [001] 2076465.200156: rpc_task_run_action:
>>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>>> runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_refresh
>>>>            <...>-1461944 [001] 2076465.200163: rpc_task_run_action:
>>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>>> runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_refreshresult
>>>>            <...>-1461944 [001] 2076465.200163: rpc_task_run_action:
>>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>>> runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_allocate
>>>>            <...>-1461944 [001] 2076465.200168: rpc_buf_alloc:
>>>> task:57752@6 callsize=3D548 recvsize=3D104 status=3D0
>>>>            <...>-1461944 [001] 2076465.200168: rpc_task_run_action:
>>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>>> runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_encode
>>>>            <...>-1461944 [001] 2076465.200173: rpc_task_run_action:
>>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>>> runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D0
>>>> action=3Dcall_connect
>>>>            <...>-1461944 [001] 2076465.200174: rpc_call_rpcerror:
>>>> task:57752@6 tk_status=3D-107 rpc_status=3D-107
>>>>            <...>-1461944 [001] 2076465.200174: rpc_task_run_action:
>>>> task:57752@6 flags=3DASYNC|DYNAMIC|SOFT|NOCONNECT
>>>> runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D-107
>>>> action=3Drpc_exit_task
>>>>
>>>> It's reporting ENOTCON. I'm not really sure if this is related to co=
py
>>>> offload but more perhaps doing callbacks over RDMA/IB.
>>> If the client is awaiting a COPY notification callback, I can see why=

>>> a lost CB channel would cause the client to wait indefinitely.
>>> The copy mechanism has to deal with this contingency... Perhaps the
>>> server could force a disconnect so that the client and server have an=

>>> opportunity to re-establish the callback channel. <shrug>
>>> In any event, the trace log above shows nothing more than "hey, it's
>>> not working." Are there any rpcrdma trace events we can look at to
>>> determine why the backchannel is getting lost?
>>
>> The trace log attached to my previous mail has it enabled, along with =
nfsd and sunrpc.
>> I'm attaching the two files again here.
>=20
> Thanks, Timo.
>=20
> The first CB_OFFLOAD callback succeeds:
>=20
> 2076155.216687: nfsd_cb_work:         addr=3D10.110.10.252:0 client 602=
eb645:daa037ae procedure=3DCB_OFFLOAD
> 2076155.216704: rpc_request:          task:57746@6 nfs4_cbv1 CB_OFFLOAD=
 (async)
>=20
> 2076155.216975: rpc_stats_latency:    task:57746@6 xid=3D0xff9faaf9 nfs=
4_cbv1 CB_OFFLOAD backlog=3D33 rtt=3D195 execute=3D282
> 2076155.216977: nfsd_cb_done:         addr=3D10.110.10.252:0 client 602=
eb645:daa037ae status=3D0
>=20
>=20
> About 305 seconds later, the autodisconnect timer fires. I'm not sure i=
f this is the backchannel transport, but it looks suspicious:
>=20
> 2076460.314954: xprt_disconnect_auto: peer=3D[10.110.10.252]:0 state=3D=
LOCKED|CONNECTED|BOUND
> 2076460.314957: xprt_disconnect_done: peer=3D[10.110.10.252]:0 state=3D=
LOCKED|CONNECTED|BOUND
>=20
>=20
> The next CB_OFFLOAD callback fails because the xprt has been marked "di=
sconnected" and the request's NOCONNECT flag is set.
>=20
> 2076465.200136: nfsd_cb_work:         addr=3D10.110.10.252:0 client 602=
eb645:daa037ae procedure=3DCB_OFFLOAD
> 2076465.200151: rpc_request:          task:57752@6 nfs4_cbv1 CB_OFFLOAD=
 (async)
>=20
> 2076465.200168: rpc_task_run_action:  task:57752@6 flags=3DASYNC|DYNAMI=
C|SOFT|NOCONNECT runstate=3DRUNNING|ACTIVE status=3D0 action=3Dcall_encod=
e
> 2076465.200173: rpc_task_run_action:  task:57752@6 flags=3DASYNC|DYNAMI=
C|SOFT|NOCONNECT runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D0=
 action=3Dcall_connect
> 2076465.200174: rpc_call_rpcerror:    task:57752@6 tk_status=3D-107 rpc=
_status=3D-107
> 2076465.200174: rpc_task_run_action:  task:57752@6 flags=3DASYNC|DYNAMI=
C|SOFT|NOCONNECT runstate=3DRUNNING|ACTIVE|NEED_XMIT|NEED_RECV status=3D-=
107 action=3Drpc_exit_task
> 2076465.200179: nfsd_cb_done:         addr=3D10.110.10.252:0 client 602=
eb645:daa037ae status=3D-107
> 2076465.200180: nfsd_cb_state:        addr=3D10.110.10.252:0 client 602=
eb645:daa037ae state=3DFAULT
>=20
>=20
> Perhaps RPC clients for NFSv4.1+ callback should be created with
> the RPC_CLNT_CREATE_NO_IDLE_TIMEOUT flag.

I added that flag to the callback client creation flags, and so far=20
after a few hours of uptime, copying still works.
Can't say anything about that being the appropriate fix for the issue at =

hand, as I lack the necessary insight into the NFS code, but I'll leave=20
it running like that for now and observe.

Can also gladly test any other patches.


Thanks,
Timo


--------------ms090801090503060000030808
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
LnAuQS4xLDAqBgNVBAMMI0FjdGFsaXMgQ2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczMIIC
IjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEA7eaHlqHBpLbtwkJV9z8PDyJgXxPgpkOI
hkmReRwbLxpQD9xGAe72ujqGzFFh78QPgAhxKVqtGHzYeq0VJVCzhnCKRBbVX+JwIhL3ULYh
UAZrViUp952qDB6qTL5sGeJS9F69VPSR5k6pFNw7mHDTTt0voWFg2aVkG3khomzVXoieJGOi
Q4dH76paCtQbLkt59joAKz2BnwGLQ4wr09nfumJt5AKx2YxHK2XgSPslVZ4z8G00gimsfA7U
tjT/wiekY6Z0b7ksLrEcvODncHQe9VSrNRA149SE3AlkWaZM/joVei/GYfj9K5jkiReinR4m
qM353FEceLOeBhSTURpMdQ5wsXLi9DSTGBuNv4aw2Dozb/qBlkhGTvwk92mi0jAecE22Sn3A
9UfrU2p1w/uRs+TIteQ0xO0B/J2mY2caqocsS9SsriIGlQ8b0LT0o6Ob07KGtPa5/lIvMmx5
72Dv2v+vDiECByxm1Hdgjp8JtE4mdyYP6GBscJyT71NZw1zXHnFkyCbxReag9qaSR9x4CVVX
j1BDmNROCqd5NAfIXUXYTFeZ/jukQigkxXGWhEhfLBC4Ha6pwizz9fq1+wwPKcWaF9P/SZOu
BDrG30MiyCZa66G9mEtF5ZLuh4rGfKqxy4Z5Mxecuzt+MZmrSKfKGeXOeED/iuX5Z02M1o7i
MS8CAwEAAaOCAfQwggHwMA8GA1UdEwEB/wQFMAMBAf8wHwYDVR0jBBgwFoAUUtiIOsifeGbt
ifN7OHCUyQICNtAwQQYIKwYBBQUHAQEENTAzMDEGCCsGAQUFBzABhiVodHRwOi8vb2NzcDA1
LmFjdGFsaXMuaXQvVkEvQVVUSC1ST09UMEUGA1UdIAQ+MDwwOgYEVR0gADAyMDAGCCsGAQUF
BwIBFiRodHRwczovL3d3dy5hY3RhbGlzLml0L2FyZWEtZG93bmxvYWQwHQYDVR0lBBYwFAYI
KwYBBQUHAwIGCCsGAQUFBwMEMIHjBgNVHR8EgdswgdgwgZaggZOggZCGgY1sZGFwOi8vbGRh
cDA1LmFjdGFsaXMuaXQvY24lM2RBY3RhbGlzJTIwQXV0aGVudGljYXRpb24lMjBSb290JTIw
Q0EsbyUzZEFjdGFsaXMlMjBTLnAuQS4lMmYwMzM1ODUyMDk2NyxjJTNkSVQ/Y2VydGlmaWNh
dGVSZXZvY2F0aW9uTGlzdDtiaW5hcnkwPaA7oDmGN2h0dHA6Ly9jcmwwNS5hY3RhbGlzLml0
L1JlcG9zaXRvcnkvQVVUSC1ST09UL2dldExhc3RDUkwwHQYDVR0OBBYEFL6XqaqEv4C/EFN9
CTL54S4yG893MA4GA1UdDwEB/wQEAwIBBjANBgkqhkiG9w0BAQsFAAOCAgEAJpvnG1kNdLMS
A+nnVfeEgIXNQsM7YRxXx6bmEt9IIrFlH1qYKeNw4NV8xtop91Rle168wghmYeCTP10FqfuK
MZsleNkI8/b3PBkZLIKOl9p2Dmz2Gc0I3WvcMbAgd/IuBtx998PJX/bBb5dMZuGV2drNmxfz
3ar6ytGYLxedfjKCD55Yv8CQcN6e9sW5OUm9TJ3kjt7Wdvd1hcw5s+7bhlND38rWFJBuzump
5xqm1NSOggOkFSlKnhSz6HUjgwBaid6Ypig9L1/TLrkmtEIpx+wpIj7WTA9JqcMMyLJ0rN6j
jpetLSGUDk3NCOpQntSy4a8+0O+SepzS/Tec1cGdSN6Ni2/A7ewQNd1Rbmb2SM2qVBlfN0e6
ZklWo9QYpNZyf0d/d3upsKabE9eNCg1S4eDnp8sJqdlaQQ7hI/UYCAgDtLIm7/J9+/S2zuwE
WtJMPcvaYIBczdjwF9uW+8NJ/Zu/JKb98971uua7OsJexPFRBzX7/PnJ2/NXcTdwudShJc/p
d9c3IRU7qw+RxRKchIczv3zEuQJMHkSSM8KM8TbOzi/0v0lU6SSyS9bpGdZZxx19Hd8Qs0cv
+R6nyt7ohttizwefkYzQ6GzwIwM9gSjH5Bf/r9Kc5/JqqpKKUGicxAGy2zKYEGB0Qo761Mcc
IyclBW9mfuNFDbTBeDEyu80xggPzMIID7wIBATCBljCBgTELMAkGA1UEBhMCSVQxEDAOBgNV
BAgMB0JlcmdhbW8xGTAXBgNVBAcMEFBvbnRlIFNhbiBQaWV0cm8xFzAVBgNVBAoMDkFjdGFs
aXMgUy5wLkEuMSwwKgYDVQQDDCNBY3RhbGlzIENsaWVudCBBdXRoZW50aWNhdGlvbiBDQSBH
MwIQCP8se1eXTyBvFrjHrZ83LDANBglghkgBZQMEAgEFAKCCAi0wGAYJKoZIhvcNAQkDMQsG
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMjEwMjIwMjEwMzI5WjAvBgkqhkiG9w0BCQQx
IgQgtBtYT4XBmxnIDpMzNH8D1htc71Ht+YB+GuCdDudX9vkwbAYJKoZIhvcNAQkPMV8wXTAL
BglghkgBZQMEASowCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMA4GCCqGSIb3DQMCAgIAgDAN
BggqhkiG9w0DAgIBQDAHBgUrDgMCBzANBggqhkiG9w0DAgIBKDCBpwYJKwYBBAGCNxAEMYGZ
MIGWMIGBMQswCQYDVQQGEwJJVDEQMA4GA1UECAwHQmVyZ2FtbzEZMBcGA1UEBwwQUG9udGUg
U2FuIFBpZXRybzEXMBUGA1UECgwOQWN0YWxpcyBTLnAuQS4xLDAqBgNVBAMMI0FjdGFsaXMg
Q2xpZW50IEF1dGhlbnRpY2F0aW9uIENBIEczAhAI/yx7V5dPIG8WuMetnzcsMIGpBgsqhkiG
9w0BCRACCzGBmaCBljCBgTELMAkGA1UEBhMCSVQxEDAOBgNVBAgMB0JlcmdhbW8xGTAXBgNV
BAcMEFBvbnRlIFNhbiBQaWV0cm8xFzAVBgNVBAoMDkFjdGFsaXMgUy5wLkEuMSwwKgYDVQQD
DCNBY3RhbGlzIENsaWVudCBBdXRoZW50aWNhdGlvbiBDQSBHMwIQCP8se1eXTyBvFrjHrZ83
LDANBgkqhkiG9w0BAQEFAASCAQAG+EiWTGpFok03lvCe8mcupvuL6BVHwpqS7yGWHdTyhZuP
/IBz6f8Nlq7CAxTvRdKJqyy/25pXbpddLKo3xdjCDamAydDqiS9OAyJ2qdW2kwkdAQaPOXUb
AP28IR0BuB94dzbh7/v1MlpELOS8byQRUnjF/2rXbbMlYzSoZqUgt9kERYuTvZVNOT/EMdQ+
DYnFQ67Co0YOf7uINUK5fnZf92CL7rUiAYFrDh0d0is1EU7U73XYwwEv7Vr80a9Pv8h9YwsS
Vq93Ew2qJ2J52xSb32doOdQkikvTK6U1050cgdyqiTKZayES90Pqb6eOwTONy5OwpXNt3MyB
obrthuJxAAAAAAAA
--------------ms090801090503060000030808--
